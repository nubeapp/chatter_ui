import 'dart:convert';

import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/entities/ticket.dart';
import 'package:ui/domain/services/ticket_service_interface.dart';
import 'package:http/http.dart' as http;
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/styles/logger.dart';

class TicketService implements ITicketService {
  static String get API_BASE_URL => 'http://0.0.0.0:8000/tickets';
  final http.Client client;

  TicketService({required this.client});

  // It returns all the tickets that has a user
  @override
  Future<List<Ticket>> getTicketsByUserIdEventId(int eventId) async {
    final response =
        await client.get(Uri.parse('$API_BASE_URL/events/$eventId'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Ticket.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get tickets');
    }
  }

  // It returns all the tickets that has a user
  @override
  Future<List<Ticket>> getTicketsByUserId() async {
    final response = await client.get(Uri.parse(API_BASE_URL));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Ticket.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get tickets');
    }
  }

  // This method generates all the references for each ticket for specific event
  @override
  Future<List<Ticket>> createTickets(Event event, int ticketLimit) async {
    List<Ticket> tickets = _generateTicketsByEvent(event, ticketLimit);

    Logger.debug('Creating tickets...');
    final response = await client.post(
      Uri.parse(API_BASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(tickets.map((ticket) => ticket.toJson()).toList()),
    );

    if (response.statusCode == 201) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      Logger.info('Tickets have been created successfully!');
      return jsonList.map((json) => Ticket.fromJson(json)).toList();
    } else {
      Logger.error('Failed to create tickets');
      throw Exception('Failed to create tickets');
    }
  }

  // This refers when user buy a ticket for an event, not when user buy a ticket from a seller
  @override
  Future<List<Ticket>> buyTicket(Order order) async {
    final response = await client.post(
      Uri.parse('$API_BASE_URL/buy'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(order.toJson()),
    );

    if (response.statusCode == 201) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      Logger.info('Tickets have been bought successfully!');
      return jsonList.map((json) => Ticket.fromJson(json)).toList();
    } else if (response.statusCode == 400) {
      throw Exception('The event has reached its ticket limit');
    } else if (response.statusCode == 409) {
      throw Exception('The user has already bought a ticket for this event');
    } else {
      throw Exception('Failed to buy ticket');
    }
  }

  /// Private functions

  List<Ticket> _generateTicketsByEvent(Event event, int ticketLimit) {
    List<String> references =
        Helpers.generateRandomReferenceListByLimit(ticketLimit);
    List<Ticket> tickets = List.empty(growable: true);
    for (String reference in references) {
      Ticket ticket = Ticket(
        price: 80.0,
        reference: reference,
        eventId: event.id!,
      );
      tickets.add(ticket);
    }
    return tickets;
  }
}
