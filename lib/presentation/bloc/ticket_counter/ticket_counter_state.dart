abstract class TicketCounterState {}

class TicketCounterInitialState extends TicketCounterState {}

class TicketCounterUpdatedState extends TicketCounterState {
  final int ticketCounter;

  TicketCounterUpdatedState(this.ticketCounter);
}
