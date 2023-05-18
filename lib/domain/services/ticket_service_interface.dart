import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/entities/ticket/ticket.dart';

abstract class ITicketService {
  Future<List<Ticket>> getTicketsByUserIdEventId(int eventId);
  Future<List<Ticket>> getTicketsByUserId();
  Future<List<Ticket>> createTickets(
      Event event, double price, int ticketLimit);
  Future<List<Ticket>> buyTickets(Order order);
}
