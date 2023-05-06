import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/infrastructure/services/event_service.dart';
import 'package:http/http.dart' as http;

import '../../../mocks/mock_objects.dart';
import '../../../mocks/mock_responses.dart';
import 'event_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late IEventService eventService;
  const String API_BASE_URL = 'http://0.0.0.0:8000/events';

  // List<Event> mockedEvents = const [
  //   Event(title: 'Event 1 with owner_id 30'),
  //   Event(title: 'Event 2 with owner_id 30'),
  //   Event(title: 'Event 1 with owner_id 32'),
  // ];

  // setUp(() async {
  //   eventService = EventService();
  //   mockedEvents.forEach((e) async => await eventService.createEvent(e));
  // });

  // tearDown(() async {
  //   eventService.deleteAllEvents();
  // });

  group('EventService', () {
    group('getEvents', () {
      test('getEvents returns a list of events', () async {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);

        when(mockClient.get(Uri.parse(API_BASE_URL))).thenAnswer((_) async =>
            http.Response(json.encode(mockEventListResponse), 200));

        final events = await eventService.getEvents();

        expect(events, isA<List<Event>>());
        expect(events.length, equals(2));
        expect(events[0].id, equals(1));
        expect(events[1].id, equals(2));
        expect(events[0].title, 'Bad Bunny Concert');
        expect(events[1].title, 'Rosalia Concert');
        expect(events[0].date, DateFormat("dd-MM-yyyy").parse('07-12-2023'));
        expect(events[1].date, DateFormat("dd-MM-yyyy").parse('14-12-2023'));
        expect(events[0].time, '18:00');
        expect(events[1].time, '18:00');
        expect(events[0].venue, 'Wizink Center');
        expect(events[1].venue, 'Wizink Center');
        expect(events[0].ticketLimit, equals(1000));
        expect(events[1].ticketLimit, equals(1000));
        expect(events[0].organization!.id, equals(1));
        expect(events[1].organization!.id, equals(1));
        expect(events[0].organization!.name, 'UNIVERSAL MUSIC SPAIN');
        expect(events[1].organization!.name, 'UNIVERSAL MUSIC SPAIN');

        verify(mockClient.get(Uri.parse(API_BASE_URL))).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);

        when(mockClient.get(Uri.parse(API_BASE_URL)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(eventService.getEvents(), throwsException);

        verify(mockClient.get(Uri.parse(API_BASE_URL))).called(1);
      });

      test('getEventsByOrganizationId returns a list of events', () async {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockOrganizationId = 1;

        when(mockClient.get(Uri.parse('$API_BASE_URL/$mockOrganizationId')))
            .thenAnswer((_) async =>
                http.Response(json.encode(mockEventListResponse), 200));

        final events =
            await eventService.getEventsByOrganizationId(mockOrganizationId);

        expect(events, isA<List<Event>>());
        expect(events.length, equals(2));
        expect(events[0].id, equals(1));
        expect(events[1].id, equals(2));
        expect(events[0].title, 'Bad Bunny Concert');
        expect(events[1].title, 'Rosalia Concert');
        expect(events[0].date, DateFormat("dd-MM-yyyy").parse('07-12-2023'));
        expect(events[1].date, DateFormat("dd-MM-yyyy").parse('14-12-2023'));
        expect(events[0].time, '18:00');
        expect(events[1].time, '18:00');
        expect(events[0].venue, 'Wizink Center');
        expect(events[1].venue, 'Wizink Center');
        expect(events[0].ticketLimit, equals(1000));
        expect(events[1].ticketLimit, equals(1000));
        expect(events[0].organization!.id, equals(1));
        expect(events[1].organization!.id, equals(1));
        expect(events[0].organization!.name, 'UNIVERSAL MUSIC SPAIN');
        expect(events[1].organization!.name, 'UNIVERSAL MUSIC SPAIN');

        verify(mockClient.get(Uri.parse('$API_BASE_URL/$mockOrganizationId')))
            .called(1);
      });

      test(
          'throws an exception if the http call completes with an error (ByOrganizationId)',
          () {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockOrganizationId = 1;

        when(mockClient.get(Uri.parse('$API_BASE_URL/$mockOrganizationId')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(eventService.getEventsByOrganizationId(mockOrganizationId),
            throwsException);

        verify(mockClient.get(Uri.parse('$API_BASE_URL/$mockOrganizationId')))
            .called(1);
      });

      test('getEventsById returns an event', () async {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockId = 1;

        when(mockClient.get(Uri.parse('$API_BASE_URL/event/$mockId')))
            .thenAnswer((_) async =>
                http.Response(json.encode(mockEventResponse), 200));

        final event = await eventService.getEventById(mockId);

        expect(event, isA<Event>());
        expect(event.id, equals(1));
        expect(event.title, 'Bad Bunny Concert');
        expect(event.date, DateFormat("dd-MM-yyyy").parse('07-12-2023'));
        expect(event.time, '18:00');
        expect(event.venue, 'Wizink Center');
        expect(event.ticketLimit, equals(1000));
        expect(event.organization!.id, equals(1));
        expect(event.organization!.name, 'UNIVERSAL MUSIC SPAIN');

        verify(mockClient.get(Uri.parse('$API_BASE_URL/event/$mockId')))
            .called(1);
      });

      test(
          'throws an exception if the http call completes with an error (ById)',
          () {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockId = 1;

        when(mockClient.get(Uri.parse('$API_BASE_URL/event/$mockId')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(eventService.getEventById(mockId), throwsException);

        verify(mockClient.get(Uri.parse('$API_BASE_URL/event/$mockId')))
            .called(1);
      });

      // test('returns list of events on success', () async {
      //   // Act
      //   final events = await eventService.getEvents();

      //   // Assertions
      //   expect(events.length, equals(3));
      //   expect(events.first.title, equals(mockedEvents.first.title));
      //   expect(events.first.ownerId, equals(mockedEvents.first.ownerId));
      // });

      // test('return list of events on success by owner_id', () async {
      //   final events = await eventService.getEventsByOwnerId(30);

      //   expect(events, isA<List<Event>>());
      //   expect(events.length, equals(2));
      //   expect(events.first.title, 'Event 1 with owner_id 30');
      //   expect(events.first.ownerId, 30);
      //   expect(events.first.completed, false);
      // });

      // test('return event on success', () async {
      //   final events = await eventService.getEvents();
      //   final eventId = events.first.id!;
      //   final event = await eventService.getEventById(eventId);

      //   expect(event.title, events.first.title);
      //   expect(event.ownerId, events.first.ownerId);
      //   expect(event.completed, events.first.completed);
      // });

      // test('throws exception on failure', () async {
      //   final events = await eventService.getEvents();
      //   expect(() => eventService.getEventById(events.last.id! + 1),
      //       throwsException);
      // });
    });

    group('createEvent', () {
      test('createEvent creates new event', () async {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);

        when(mockClient.post(Uri.parse(API_BASE_URL),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode(mockEventObject.toJson())))
            .thenAnswer((_) async =>
                http.Response(json.encode(mockEventResponse), 201));

        final event = await eventService.createEvent(mockEventObject);

        expect(event, isA<Event>());
        expect(event.id, equals(1));
        expect(event.title, 'Bad Bunny Concert');
        expect(event.date, DateFormat("dd-MM-yyyy").parse('07-12-2023'));
        expect(event.time, '18:00');
        expect(event.venue, 'Wizink Center');
        expect(event.ticketLimit, equals(1000));
        expect(event.organization!.id, equals(1));
        expect(event.organization!.name, 'UNIVERSAL MUSIC SPAIN');

        verify(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockEventObject.toJson()),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);

        when(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockEventObject.toJson()),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(eventService.createEvent(mockEventObject), throwsException);

        verify(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockEventObject.toJson()),
        )).called(1);
      });
      // Event newEvent = const Event(title: "Event 3 with owner_id 30");
      // Event newEventError = const Event(title: "Event does not exist");

      // test('creates a new event and add it to the list', () async {
      //   final eventsDatabase = await eventService.getEvents();
      //   final event = await eventService.createEvent(newEvent);
      //   final eventsAfterCreate = await eventService.getEvents();

      //   expect(eventsAfterCreate.length, eventsDatabase.length + 1);
      //   expect(eventsAfterCreate.last.title, event.title);
      //   expect(eventsAfterCreate.last.ownerId, event.ownerId);
      // });

      // test('throws exception on failure', () {
      //   expect(() => eventService.createEvent(newEventError), throwsException);
      // });
    });

    group('updateEvent', () {
      test('updateEvent updates an event', () async {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockId = 1;

        when(mockClient.put(Uri.parse('$API_BASE_URL/$mockId'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode(mockEventObject.toJson())))
            .thenAnswer((_) async =>
                http.Response(json.encode(mockEventResponse), 200));

        final event =
            await eventService.updateEventById(mockId, mockEventObject);

        expect(event, isA<Event>());
        expect(event.id, equals(1));
        expect(event.title, 'Bad Bunny Concert');
        expect(event.date, DateFormat("dd-MM-yyyy").parse('07-12-2023'));
        expect(event.time, '18:00');
        expect(event.venue, 'Wizink Center');
        expect(event.ticketLimit, equals(1000));
        expect(event.organization!.id, equals(1));
        expect(event.organization!.name, 'UNIVERSAL MUSIC SPAIN');

        verify(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockEventObject.toJson()),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockId = 1;

        when(mockClient.put(Uri.parse('$API_BASE_URL/$mockId'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode(mockEventObject.toJson())))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(eventService.updateEventById(mockId, mockEventObject),
            throwsException);

        verify(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockEventObject.toJson()),
        )).called(1);
      });
      // Event updatedEvent =
      //     const Event(ownerId: 30, title: 'Updated title', completed: true);

      // test('update event on success', () async {
      //   final events = await eventService.getEvents();

      //   await eventService.updateEventById(events.first.id!, updatedEvent);

      //   final eventAfterUpdated =
      //       await eventService.getEventById(events.first.id!);

      //   expect(eventAfterUpdated.title, 'Updated title');
      //   expect(eventAfterUpdated.completed, true);
      // });

      // test('throw exception on failure', () async {
      //   final events = await eventService.getEvents();
      //   expect(
      //       () =>
      //           eventService.updateEventById(events.last.id! + 1, updatedEvent),
      //       throwsException);
      // });
    });

    group('deleteEventById', () {
      test('deleteEventById is called once', () async {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockId = 1;

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/event/$mockId'),
        )).thenAnswer((_) async => http.Response('[]', 204));

        await eventService.deleteEventById(mockId);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/event/$mockId'),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockId = 1;

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/event/$mockId'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(eventService.deleteEventById(mockId), throwsException);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/event/$mockId'),
        )).called(1);
      });
      // test('delete event by eventId on success', () async {
      //   final events = await eventService.getEvents();
      //   final int eventId = events.last.id!;

      //   await eventService.deleteEventById(eventId);

      //   expect(() => eventService.deleteEventById(eventId), throwsException);
      // });

      // test('throw exception on failure', () async {
      //   final events = await eventService.getEvents();

      //   expect(() => eventService.deleteEventById(events.last.id! + 1),
      //       throwsException);
      // });
    });

    group('deleteEventByOrganizationId', () {
      test('deleteEventByOrganizationId is called once', () async {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockOrganizationId = 1;

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockOrganizationId'),
        )).thenAnswer((_) async => http.Response('[]', 204));

        await eventService.deleteEventsByOrganizationId(mockOrganizationId);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockOrganizationId'),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        eventService = EventService(client: mockClient);
        const int mockOrganizationId = 1;

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockOrganizationId'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(eventService.deleteEventsByOrganizationId(mockOrganizationId),
            throwsException);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockOrganizationId'),
        )).called(1);
      });
      // test('delete event by ownerId on success', () async {
      //   final events = await eventService.getEvents();
      //   final int ownerId = events.last.ownerId!;

      //   await eventService.deleteEventsByOwnerId(ownerId);

      //   final eventsByOwner = await eventService.getEventsByOwnerId(ownerId);

      //   expect(eventsByOwner.length, equals(0));
      // });
    });
  });
}
