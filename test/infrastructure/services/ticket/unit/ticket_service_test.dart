import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ui/domain/entities/event_queue_entry.dart';
import 'package:ui/domain/entities/ticket.dart';
import 'package:ui/domain/services/ticket_service_interface.dart';
import 'package:ui/infrastructure/services/ticket_service.dart';

import '../../../mocks/mock_responses.dart';
import 'ticket_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ITicketService ticketService;
  const String API_BASE_URL = 'http://0.0.0.0:8000/tickets';

  group('TicketService', () {
    group('buyTicket', () {
      test('returns the ticket bought', () async {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);
        const mockEventId = 1;

        when(mockClient.post(
          Uri.parse('$API_BASE_URL/buy'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: {
            'event_id': mockEventId,
          },
        )).thenAnswer(
            (_) async => http.Response(json.encode(mockTicketResponse), 200));

        final ticket = await ticketService.buyTicket(mockEventId);

        expect(ticket, isA<Ticket>());
        expect(ticket.id, equals(1));
        expect(ticket.reference, '001AUMS20230426ABAD');
        expect(ticket.user.name, 'John');
        expect(ticket.user.email, 'johndoe@example.com');
        expect(ticket.event.date,
            DateFormat("dd-MM-yyyy HH:mm").parse('07-12-2023 18:00'));
        expect(ticket.event.venue, 'Wizink Center, Av. de Felipe II');
        expect(ticket.event.organization!.code, 'UMS');

        verify(mockClient.post(
          Uri.parse('$API_BASE_URL/buy'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: {
            'event_id': mockEventId,
          },
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);
        const mockEventId = 1;

        when(mockClient.post(
          Uri.parse('$API_BASE_URL/buy'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: {
            'event_id': mockEventId,
          },
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(ticketService.buyTicket(mockEventId), throwsException);

        verify(mockClient.post(
          Uri.parse('$API_BASE_URL/buy'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: {
            'event_id': mockEventId,
          },
        )).called(1);
      });
    });

    group('getTicketsByUserId', () {
      test('returns list of tickets for the user', () async {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);
        const mockUserId = 1;

        when(mockClient
                .get(Uri.parse('$API_BASE_URL/users/$mockUserId/tickets')))
            .thenAnswer((_) async =>
                http.Response(json.encode(mockTicketListResponse), 200));

        final tickets = await ticketService.getTicketsByUserId(mockUserId);

        expect(tickets, isA<List<Ticket>>());
        expect(tickets.length, equals(2));
        expect(tickets[0].reference, '001AUMS20230426ABAD');
        expect(tickets[1].reference, '001AUMS20230426AROS');
        expect(tickets[0].user.name, 'John');
        expect(tickets[1].user.name, 'John');
        expect(tickets[0].user.email, 'johndoe@example.com');
        expect(tickets[1].user.email, 'johndoe@example.com');
        expect(tickets[0].event.date,
            DateFormat("dd-MM-yyyy HH:mm").parse('07-12-2023 18:00'));
        expect(tickets[1].event.date,
            DateFormat("dd-MM-yyyy HH:mm").parse('14-12-2023 18:00'));
        expect(tickets[0].event.venue, 'Wizink Center, Av. de Felipe II');
        expect(tickets[1].event.venue, 'Wizink Center, Av. de Felipe II');
        expect(tickets[0].event.title, 'Bad Bunny Concert');
        expect(tickets[1].event.title, 'Rosalia Concert');
        expect(tickets[0].event.organization!.code, 'UMS');
        expect(tickets[1].event.organization!.code, 'UMS');

        verify(mockClient
                .get(Uri.parse('$API_BASE_URL/users/$mockUserId/tickets')))
            .called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);
        const mockUserId = 1;

        when(mockClient
                .get(Uri.parse('$API_BASE_URL/users/$mockUserId/tickets')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(ticketService.getTicketsByUserId(mockUserId), throwsException);

        verify(mockClient
                .get(Uri.parse('$API_BASE_URL/users/$mockUserId/tickets')))
            .called(1);
      });
    });

    group('getEventQueueByEventId', () {
      test('returns the queue of an event', () async {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);
        const mockEventId = 1;

        when(mockClient
                .get(Uri.parse('$API_BASE_URL/events/$mockEventId/queue')))
            .thenAnswer((_) async =>
                http.Response(json.encode(mockQueueResponse), 200));

        final queue = await ticketService.getEventQueueByEventId(mockEventId);

        expect(queue, isA<List<EventQueueEntry>>());
        expect(queue.length, equals(3));
        expect(queue[0].eventId, equals(1));
        expect(queue[1].eventId, equals(1));
        expect(queue[2].eventId, equals(2));
        expect(queue[0].user.email, 'johndoe@example.com');
        expect(queue[1].user.email, 'janesmith@example.com');
        expect(queue[2].user.email, 'johndoe@example.com');

        verify(mockClient
                .get(Uri.parse('$API_BASE_URL/events/$mockEventId/queue')))
            .called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);
        const mockEventId = 1;

        when(mockClient
                .get(Uri.parse('$API_BASE_URL/events/$mockEventId/queue')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(
            ticketService.getEventQueueByEventId(mockEventId), throwsException);

        verify(mockClient
                .get(Uri.parse('$API_BASE_URL/events/$mockEventId/queue')))
            .called(1);
      });
    });
  });
}
