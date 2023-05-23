import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/entities/ticket/create_ticket.dart';
import 'package:ui/domain/entities/ticket/ticket.dart';

abstract class ITicketService {
  Future<List<Ticket>> getTicketsByUserIdEventId(int eventId);
  Future<List<Ticket>> getTicketsByUserId();
  Future<List<Ticket>> createTickets(CreateTicket ticketData);
  Future<List<Ticket>> buyTickets(Order order);
}
