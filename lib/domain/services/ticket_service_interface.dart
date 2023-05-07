import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/ticket.dart';

abstract class ITicketService {
  Future<Ticket> buyTicket(
      int eventId); // This mean you assist and event, so you bought a ticket
  Future<List<Ticket>> getTicketsByUserId(int userId);
  Future<List<Ticket>> createTicketsByEvent(Event event);
  // Future<List<EventQueueEntry>> getEventQueueByEventId(int eventId);
  // Future<Ticket?> sellTicket(int sellerId, int eventId);
  // Future<EventQueueEntry> subscribeToEventQueue(int userId, int eventId);
}
