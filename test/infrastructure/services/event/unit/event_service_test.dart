import 'package:flutter_test/flutter_test.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/infrastructure/services/event_service.dart';

void main() {
  late IEventService eventService;

  List<Event> mockedEvents = const [
    Event(title: 'Event 1 with owner_id 30'),
    Event(title: 'Event 2 with owner_id 30'),
    Event(title: 'Event 1 with owner_id 32'),
  ];

  setUp(() async {
    eventService = EventService();
    mockedEvents.forEach((e) async => await eventService.createEvent(e));
  });

  tearDown(() async {
    eventService.deleteAllEvents();
  });

  group('EventService', () {
    group('getEvents', () {
      test('returns list of events on success', () async {
        // Act
        final events = await eventService.getEvents();

        // Assertions
        expect(events.length, equals(3));
        expect(events.first.title, equals(mockedEvents.first.title));
        expect(events.first.ownerId, equals(mockedEvents.first.ownerId));
      });

      test('return list of events on success by owner_id', () async {
        final events = await eventService.getEventsByOwnerId(30);

        expect(events, isA<List<Event>>());
        expect(events.length, equals(2));
        expect(events.first.title, 'Event 1 with owner_id 30');
        expect(events.first.ownerId, 30);
        expect(events.first.completed, false);
      });

      test('return event on success', () async {
        final events = await eventService.getEvents();
        final eventId = events.first.id!;
        final event = await eventService.getEventById(eventId);

        expect(event.title, events.first.title);
        expect(event.ownerId, events.first.ownerId);
        expect(event.completed, events.first.completed);
      });

      test('throws exception on failure', () async {
        final events = await eventService.getEvents();
        expect(() => eventService.getEventById(events.last.id! + 1),
            throwsException);
      });
    });

    group('createEvent', () {
      Event newEvent = const Event(title: "Event 3 with owner_id 30");
      Event newEventError = const Event(title: "Event does not exist");

      test('creates a new event and add it to the list', () async {
        final eventsDatabase = await eventService.getEvents();
        final event = await eventService.createEvent(newEvent);
        final eventsAfterCreate = await eventService.getEvents();

        expect(eventsAfterCreate.length, eventsDatabase.length + 1);
        expect(eventsAfterCreate.last.title, event.title);
        expect(eventsAfterCreate.last.ownerId, event.ownerId);
      });

      test('throws exception on failure', () {
        expect(() => eventService.createEvent(newEventError), throwsException);
      });
    });

    group('updateEvent', () {
      Event updatedEvent =
          const Event(ownerId: 30, title: 'Updated title', completed: true);

      test('update event on success', () async {
        final events = await eventService.getEvents();

        await eventService.updateEventById(events.first.id!, updatedEvent);

        final eventAfterUpdated =
            await eventService.getEventById(events.first.id!);

        expect(eventAfterUpdated.title, 'Updated title');
        expect(eventAfterUpdated.completed, true);
      });

      test('throw exception on failure', () async {
        final events = await eventService.getEvents();
        expect(
            () =>
                eventService.updateEventById(events.last.id! + 1, updatedEvent),
            throwsException);
      });
    });

    group('deleteEventById', () {
      test('delete event by eventId on success', () async {
        final events = await eventService.getEvents();
        final int eventId = events.last.id!;

        await eventService.deleteEventById(eventId);

        expect(() => eventService.deleteEventById(eventId), throwsException);
      });

      test('throw exception on failure', () async {
        final events = await eventService.getEvents();

        expect(() => eventService.deleteEventById(events.last.id! + 1),
            throwsException);
      });
    });

    group('deleteEventByOwnerId', () {
      test('delete event by ownerId on success', () async {
        final events = await eventService.getEvents();
        final int ownerId = events.last.ownerId!;

        await eventService.deleteEventsByOwnerId(ownerId);

        final eventsByOwner = await eventService.getEventsByOwnerId(ownerId);

        expect(eventsByOwner.length, equals(0));
      });
    });

    group('deleteEvents', () {
      test('delete events on success', () async {
        await eventService.deleteAllEvents();

        final events = await eventService.getEvents();

        expect(events.length, equals(0));
      });
    });
  });
}
