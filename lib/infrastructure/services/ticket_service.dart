import 'dart:convert';

import 'package:ui/domain/entities/ticket.dart';
import 'package:ui/domain/services/ticket_service_interface.dart';
import 'package:http/http.dart' as http;
import 'package:ui/infrastructure/utilities/helpers.dart';

class TicketService implements ITicketService {
  static String get API_BASE_URL => 'http://0.0.0.0:8000/tickets';
  final http.Client client;

  TicketService({required this.client});

  // This refers when user buy a ticket for an event, not when user buy a ticket from a seller
  @override
  Future<Ticket> buyTicket(int eventId) async {
    final response = await client
        .post(Uri.parse('$API_BASE_URL/buy'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: {
      'event_id': eventId,
    });

    if (response.statusCode == 200) {
      return Ticket.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('The event has reached its ticket limit');
    } else if (response.statusCode == 409) {
      throw Exception('The user has already bought a ticket for this event');
    } else {
      throw Exception('Failed to buy ticket');
    }
  }

  // It returns all the tickets that has a user
  @override
  Future<List<Ticket>> getTicketsByUserId(int userId) async {
    final response =
        await client.get(Uri.parse('$API_BASE_URL/users/$userId/tickets'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Ticket.fromJson(json)).toList();
    } else {
      throw Exception('Failed to get tickets');
    }
  }

  // This method generates all the references for each ticket for specific event
  @override
  List<String> generateTicketReferencesByEventId(int eventId, int ticketLimit) {
    final Set<String> uniqueCodes = {};

    while (uniqueCodes.length < ticketLimit) {
      final code = Helpers.randomReference(20); // or any length you want
      uniqueCodes.add(code);
    }

    return uniqueCodes.toList();
  }

  // This method is to get the current queue of people that are subscribe to the queue
  // @override
  // Future<List<EventQueueEntry>> getEventQueueByEventId(int eventId) async {
  //   final response =
  //       await client.get(Uri.parse('$API_BASE_URL/events/$eventId/queue'));

  //   if (response.statusCode == 200) {
  //     final jsonList = jsonDecode(response.body) as List<dynamic>;
  //     return jsonList.map((json) => EventQueueEntry.fromJson(json)).toList();
  //   } else {
  //     throw Exception('Failed to get event queue');
  //   }
  // }

  // // This method is used to sell a ticket from one user to another user
  // @override
  // Future<Ticket> sellTicket(int buyerId, int eventId) async {
  //   final response = await client
  //       .post(Uri.parse('$API_BASE_URL/events/$eventId/sell_ticket'));

  //   if (response.statusCode == 200) {
  //     return Ticket.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to sell ticket');
  //   }
  // }

  // // This method is used to subscribe a queue for an event. It indicates a user wants a ticket for this event
  // @override
  // Future<EventQueueEntry> subscribeToEventQueue(int userId, int eventId) async {
  //   final response = await client.post(
  //     Uri.parse('$API_BASE_URL/events/$eventId/queue'),
  //     body: {'user_id': userId.toString()},
  //   );
  //   if (response.statusCode == 200) {
  //     return EventQueueEntry.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to subscribe to ticket queue');
  //   }
  // }
}
