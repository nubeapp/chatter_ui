abstract class TicketCounterEvent {}

class IncrementTicketCounterEvent extends TicketCounterEvent {}

class DecrementTicketCounterEvent extends TicketCounterEvent {}

class ResetTicketCounterEvent extends TicketCounterEvent {}
