import 'package:flutter/material.dart';
import 'package:ui/domain/entities/ticket/ticket.dart';
import 'package:ui/domain/entities/ticket/ticket_summary.dart';

import 'package:ui/extensions/extensions.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/pages/pages.dart';
import 'package:ui/presentation/widgets/button.dart';

class SuccessfulPurchaseScreen extends StatelessWidget {
  SuccessfulPurchaseScreen({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  final TicketSummary tickets;
  final double TRANSACTION_FEE = 2.90;
  int _nTickets = 0;
  double _ticketPrice = 0.0;
  double _totalPrice = 0.0;

  _calculatePrice() {
    _ticketPrice = tickets.tickets.first.price;
    _totalPrice = (TRANSACTION_FEE + _ticketPrice) * _nTickets;
  }

  _calculateNumberTickets() {
    _nTickets = tickets.tickets.length;
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration backgroundGradient() => const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF507188),
              Color(0xFFABB7C1),
            ],
          ),
        );

    _calculateNumberTickets();
    _calculatePrice();
    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: backgroundGradient(),
        child: Scaffold(
          // backgroundColor: const Color(0xff7ea2aa),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Center(
                  child: Icon(
                    Icons.check,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8),
                  child: Text(
                    'Payment Successful',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    'You will receive the tickets through email in a few minutes',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                  child: Container(
                    width: context.w,
                    height: context.h * 0.45,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.15),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DetailLine(concept: 'Date', value: Helpers.formatDateTime(DateTime.now())),
                          const DetailLine(concept: 'Payment method', value: 'Apple Pay'),
                          const DetailLine(concept: 'Payment Code', value: '34100875'),
                          DetailLine(concept: 'Tickets', value: '$_nTickets'),
                          DetailLine(concept: 'Subtotal', value: '${Helpers.formatWithTwoDecimals(_ticketPrice)}€ x $_nTickets'),
                          DetailLine(concept: 'Transaction Fee', value: '${Helpers.formatWithTwoDecimals(TRANSACTION_FEE)}€ x $_nTickets'),
                          const Divider(color: Colors.white),
                          DetailLine(concept: 'Total', value: '${Helpers.formatWithTwoDecimals(_totalPrice)}€')
                        ],
                      ),
                    ), // Adjust the opacity and color as needed
                  ),
                ),
                Button.white(
                  text: 'Back to home',
                  width: context.w * 0.6,
                  onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) {
                    return const MainScreen();
                  }), (r) {
                    return false;
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailLine extends StatelessWidget {
  const DetailLine({Key? key, required this.concept, required this.value}) : super(key: key);

  final String concept;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            concept,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              letterSpacing: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
