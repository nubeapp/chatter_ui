import 'package:ui/domain/entities/ticket.dart';

abstract class ITicketService {
  Future<Ticket> buyTicket(int eventId);
  Future<List<Ticket>> getTicketsByUserId(int userId);
  List<String> generateTicketReferencesByEventId(int eventId, int ticketLimit);
  // Future<List<EventQueueEntry>> getEventQueueByEventId(int eventId);
  // Future<Ticket?> sellTicket(int sellerId, int eventId);
  // Future<EventQueueEntry> subscribeToEventQueue(int userId, int eventId);
}
