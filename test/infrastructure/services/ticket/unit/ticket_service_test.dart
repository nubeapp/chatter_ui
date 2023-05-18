import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ui/domain/entities/ticket/ticket.dart';
import 'package:ui/domain/entities/ticket/ticket_status.dart';
import 'package:ui/domain/services/ticket_service_interface.dart';
import 'package:ui/infrastructure/services/ticket_service.dart';

import '../../../mocks/mock_objects.dart';
import '../../../mocks/mock_responses.dart';
import 'ticket_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late ITicketService ticketService;
  const String API_BASE_URL = 'http://0.0.0.0:8000/tickets';

  group('TicketService', () {
    group('getTicketsByUserIdEventId', () {
      test('return list of tickets for the user for the event', () async {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);
        int mockEventId = 1;

        when(mockClient.get(Uri.parse('$API_BASE_URL/events/$mockEventId')))
            .thenAnswer((_) async =>
                http.Response(json.encode(mockTicketListResponse), 200));

        final tickets =
            await ticketService.getTicketsByUserIdEventId(mockEventId);

        expect(tickets, isA<List<Ticket>>());
        expect(tickets.length, equals(2));
        expect(tickets[0].price, equals(80.0));
        expect(tickets[1].price, equals(60.0));
        expect(tickets[0].status, TicketStatus.SOLD);
        expect(tickets[1].status, TicketStatus.SOLD);
        expect(tickets[0].reference, "001AUMS20230426ABAD");
        expect(tickets[1].reference, "001AUMS20230426AROS");
        expect(tickets[0].event!.title, "Bad Bunny Concert");
        expect(tickets[1].event!.title, "Rosalia Concert");
        expect(tickets[0].event!.organization!.name, "UNIVERSAL MUSIC SPAIN");
        expect(tickets[1].event!.organization!.name, "UNIVERSAL MUSIC SPAIN");

        verify(mockClient.get(Uri.parse('$API_BASE_URL/events/$mockEventId')))
            .called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);
        int mockEventId = 1;

        when(mockClient.get(Uri.parse('$API_BASE_URL/events/$mockEventId')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(ticketService.getTicketsByUserIdEventId(mockEventId),
            throwsException);

        verify(mockClient.get(Uri.parse('$API_BASE_URL/events/$mockEventId')))
            .called(1);
      });
    });

    group('getTicketsByUserId', () {
      test('returns list of tickets for the user', () async {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);

        when(mockClient.get(Uri.parse(API_BASE_URL))).thenAnswer((_) async =>
            http.Response(json.encode(mockTicketListResponse), 200));

        final tickets = await ticketService.getTicketsByUserId();

        expect(tickets, isA<List<Ticket>>());
        expect(tickets.length, equals(2));
        expect(tickets[0].price, equals(80.0));
        expect(tickets[1].price, equals(60.0));
        expect(tickets[0].reference, '001AUMS20230426ABAD');
        expect(tickets[1].reference, '001AUMS20230426AROS');
        expect(tickets[0].event!.date,
            DateFormat("dd-MM-yyyy").parse('07-12-2023'));
        expect(tickets[0].event!.time, '18:00');
        expect(tickets[1].event!.date,
            DateFormat("dd-MM-yyyy").parse('14-12-2023'));
        expect(tickets[1].event!.time, '18:00');
        expect(tickets[0].event!.venue, 'Wizink Center');
        expect(tickets[1].event!.venue, 'Wizink Center');
        expect(tickets[0].event!.title, 'Bad Bunny Concert');
        expect(tickets[1].event!.title, 'Rosalia Concert');

        verify(mockClient.get(Uri.parse(API_BASE_URL))).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);

        when(mockClient.get(Uri.parse(API_BASE_URL)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(ticketService.getTicketsByUserId(), throwsException);

        verify(mockClient.get(Uri.parse(API_BASE_URL))).called(1);
      });
    });

    group('buyTicket', () {
      test('returns the tickets bought', () async {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);

        when(mockClient.post(
          Uri.parse('$API_BASE_URL/buy'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockOrderObject.toJson()),
        )).thenAnswer((_) async =>
            http.Response(json.encode(mockTicketListResponse), 201));

        final tickets = await ticketService.buyTickets(mockOrderObject);

        expect(tickets, isA<List<Ticket>>());
        expect(tickets[0].id, equals(1));
        expect(tickets[0].price, equals(80.0));
        expect(tickets[0].reference, '001AUMS20230426ABAD');
        expect(tickets[0].event!.date,
            DateFormat("dd-MM-yyyy").parse('07-12-2023'));
        expect(tickets[0].event!.time, '18:00');
        expect(tickets[0].event!.venue, 'Wizink Center');

        verify(mockClient.post(Uri.parse('$API_BASE_URL/buy'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode(mockOrderObject.toJson())))
            .called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        ticketService = TicketService(client: mockClient);

        when(mockClient.post(Uri.parse('$API_BASE_URL/buy'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode(mockOrderObject.toJson())))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(ticketService.buyTickets(mockOrderObject), throwsException);

        verify(mockClient.post(Uri.parse('$API_BASE_URL/buy'),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                },
                body: json.encode(mockOrderObject.toJson())))
            .called(1);
      });
    });
  });
}
