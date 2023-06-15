import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/entities/ticket/create_ticket.dart';

import '../entities/ticket/ticket_summary.dart';

abstract class ITicketService {
  Future<TicketSummary> getTicketsByUserIdEventId(int eventId);
  Future<List<TicketSummary>> getTicketsByUserId();
  Future<TicketSummary> createTickets(CreateTicket ticketData);
  Future<TicketSummary> buyTickets(Order order);
}
