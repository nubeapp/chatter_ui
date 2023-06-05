import 'package:flutter_bloc/flutter_bloc.dart';

class PurchaseBloc extends Cubit<int> {
  PurchaseBloc() : super(1);

  void decrementTicketCounter() {
    if (state > 1) {
      emit(state - 1);
    }
  }

  void incrementTicketCounter() {
    if (state < 4) {
      emit(state + 1);
    }
  }
}
