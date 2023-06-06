import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

// TicketCounterBloc class
class TicketCounterBloc extends Bloc<TicketCounterEvent, TicketCounterState> {
  int ticketCounter = 1;

  TicketCounterBloc() : super(TicketCounterInitialState()) {
    on<IncrementTicketCounterEvent>(_handleIncrementTicketCounter);
    on<DecrementTicketCounterEvent>(_handleDecrementTicketCounter);
    on<ResetTicketCounterEvent>(_handleResetTicketCounter);
  }

  void incrementTicketCounter() {
    add(IncrementTicketCounterEvent());
  }

  void decrementTicketCounter() {
    add(DecrementTicketCounterEvent());
  }

  void resetTicketCounter() {
    add(ResetTicketCounterEvent());
  }

  FutureOr<void> _handleIncrementTicketCounter(IncrementTicketCounterEvent event, Emitter<TicketCounterState> emit) {
    ticketCounter++;
    ticketCounter = ticketCounter > 4 ? 4 : ticketCounter;
    emit(TicketCounterUpdatedState(ticketCounter));
  }

  FutureOr<void> _handleDecrementTicketCounter(DecrementTicketCounterEvent event, Emitter<TicketCounterState> emit) {
    ticketCounter--;
    ticketCounter = ticketCounter < 1 ? 1 : ticketCounter;
    emit(TicketCounterUpdatedState(ticketCounter));
  }

  FutureOr<void> _handleResetTicketCounter(ResetTicketCounterEvent event, Emitter<TicketCounterState> emit) {
    ticketCounter = 1;
    emit(TicketCounterUpdatedState(ticketCounter));
  }
}

// PurchaseEvent
abstract class TicketCounterEvent {}

class IncrementTicketCounterEvent extends TicketCounterEvent {}

class DecrementTicketCounterEvent extends TicketCounterEvent {}

class ResetTicketCounterEvent extends TicketCounterEvent {}

// PurchaseState
abstract class TicketCounterState {}

class TicketCounterInitialState extends TicketCounterState {}

class TicketCounterUpdatedState extends TicketCounterState {
  final int ticketCounter;

  TicketCounterUpdatedState(this.ticketCounter);
}
