import 'package:ui/domain/entities/event_queue_entry.dart';
import 'package:ui/domain/entities/ticket.dart';

abstract class ITicketService {
  Future<Ticket> buyTicket(int eventId);
  Future<List<Ticket>> getTicketsByUserId(int userId);
  Future<List<EventQueueEntry>> getEventQueueByEventId(int eventId);
  // Future<Ticket?> sellTicket(int sellerId, int eventId);
  // Future<EventQueueEntry> subscribeToEventQueue(int userId, int eventId);
}
