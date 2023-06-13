import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/entities/ticket/create_ticket.dart';
import 'package:ui/domain/entities/ticket/ticket.dart';

import '../entities/ticket/ticket_summary.dart';

abstract class ITicketService {
  Future<List<Ticket>> getTicketsByUserIdEventId(int eventId);
  Future<List<TicketSummary>> getTicketsByUserId();
  Future<List<Ticket>> createTickets(CreateTicket ticketData);
  Future<List<Ticket>> buyTickets(Order order);
}
