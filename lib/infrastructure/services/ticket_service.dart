import 'dart:convert';

import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/entities/ticket/create_ticket.dart';
import 'package:ui/domain/entities/ticket/ticket.dart';
import 'package:ui/domain/services/ticket_service_interface.dart';
import 'package:http/http.dart' as http;
import 'package:ui/presentation/styles/logger.dart';

class TicketService implements ITicketService {
  static String get API_BASE_URL => 'http://0.0.0.0:8000/tickets';
  final http.Client client;

  TicketService({required this.client});

  // It returns all the tickets that have a user for a specific event
  @override
  Future<List<Ticket>> getTicketsByUserIdEventId(int eventId) async {
    try {
      Logger.debug('Requesting tickets for event $eventId...');
      final response = await client.get(Uri.parse('$API_BASE_URL/events/$eventId'));

      if (response.statusCode == 200) {
        Logger.info('Tickets have been retrieved successfully!');
        final jsonList = jsonDecode(response.body) as List<dynamic>;
        return jsonList.map((json) => Ticket.fromJson(json)).toList();
      } else {
        Logger.error('Failed to get tickets');
        throw Exception('Failed to get tickets');
      }
    } catch (e) {
      Logger.error('An error occurred while getting tickets: $e');
      throw Exception('Failed to get tickets');
    }
  }

// It returns all the tickets that have a user for every event
  @override
  Future<List<Ticket>> getTicketsByUserId() async {
    try {
      Logger.debug('Requesting tickets...');
      final response = await client.get(Uri.parse(API_BASE_URL));

      if (response.statusCode == 200) {
        Logger.info('Tickets have been retrieved successfully!');
        final jsonList = jsonDecode(response.body) as List<dynamic>;
        return jsonList.map((json) => Ticket.fromJson(json)).toList();
      } else {
        Logger.error('Failed to get tickets');
        throw Exception('Failed to get tickets');
      }
    } catch (e) {
      Logger.error('An error occurred while getting tickets: $e');
      throw Exception('Failed to get tickets');
    }
  }

// This method generates all the references for each ticket for a specific event
  @override
  Future<List<Ticket>> createTickets(CreateTicket ticketData) async {
    try {
      Logger.debug('Creating tickets...');
      final response = await client.post(
        Uri.parse(API_BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(ticketData.toJson()),
      );

      if (response.statusCode == 201) {
        final jsonList = jsonDecode(response.body) as List<dynamic>;
        Logger.info('Tickets have been created successfully!');
        return jsonList.map((json) => Ticket.fromJson(json)).toList();
      } else {
        Logger.error('Failed to create tickets');
        throw Exception('Failed to create tickets');
      }
    } catch (e) {
      Logger.error('An error occurred while creating tickets: $e');
      throw Exception('Failed to create tickets');
    }
  }

// This refers to when a user buys a ticket for an event, not when a user buys a ticket from a seller
  @override
  Future<List<Ticket>> buyTickets(Order order) async {
    try {
      Logger.debug('Buying ${order.quantity} tickets for event ${order.eventId}...');
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
        Logger.error('The event has reached its ticket limit');
        throw Exception('The event has reached its ticket limit');
      } else if (response.statusCode == 409) {
        Logger.error('The user has already reached the limit of tickets for this event');
        throw Exception('The user has already reached the limit of tickets for this event');
      } else {
        Logger.error('Failed to buy ticket');
        throw Exception('Failed to buy ticket');
      }
    } catch (e) {
      Logger.error('An error occurred while buying tickets: $e');
      throw Exception('Failed to buy ticket');
    }
  }
}
