import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/ticket/ticket.dart';
import 'package:ui/domain/entities/ticket/ticket_summary.dart';

import 'package:ui/extensions/extensions.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/pages/pages.dart';
import 'package:ui/presentation/widgets/button.dart';

class ErrorPurchaseScreen extends StatelessWidget {
  const ErrorPurchaseScreen({
    Key? key,
    required this.event,
    required this.url,
  }) : super(key: key);

  final Event event;
  final String url;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // backgroundColor: const Color(0xff7ea2aa),
        backgroundColor: Colors.red[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Center(
                child: Icon(
                  CupertinoIcons.clear,
                  size: 120,
                  color: Colors.white,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16, bottom: 8),
                child: Text(
                  'Oh! Something went wrong...',
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
                  'Try again in a few minutes, and if error persists, contact customer service',
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
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Button.white(
                  text: 'Back to event',
                  width: context.w * 0.6,
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName("/event")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
