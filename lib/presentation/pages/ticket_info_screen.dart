import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/ticket/ticket_summary.dart';
import 'package:ui/extensions/extensions.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';

class TicketInfoScreen extends StatelessWidget {
  TicketInfoScreen({
    Key? key,
    required this.ticketSummary,
  }) : super(key: key);

  final TicketSummary ticketSummary;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget customAppBar() => AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(ticketSummary.event.title),
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(
              CupertinoIcons.chevron_left,
              size: 26,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        );

    return Scaffold(
      appBar: customAppBar(),
      backgroundColor: const Color.fromARGB(255, 24, 24, 24),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: SizedBox(
              height: context.h * 0.76,
              child: PageView.builder(
                controller: pageController,
                itemCount: ticketSummary.tickets.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: SizedBox(
                      width: context.w * 0.7,
                      height: context.h * 0.76,
                      child: Stack(
                        children: [
                          TicketEventInfoQR(event: ticketSummary.event),
                          Positioned(
                            top: context.h * 0.4999,
                            child: ClipPath(
                              clipper: TicketShapeClipper(width: context.w, height: context.h),
                              child: Container(
                                color: Colors.white,
                                width: context.w * 0.7,
                                height: context.h * 0.0095,
                              ),
                            ),
                          ),
                          Positioned(
                            top: context.h * 0.5095,
                            child: TicketQR(reference: ticketSummary.tickets[index].reference),
                          ),
                          Positioned(
                            top: context.h * 0.495,
                            left: context.w * 0.05,
                            child: const Text(
                              '-  -  -  -  -  -  -  -  -  -  -  -  -',
                              style: TextStyle(fontSize: 18, color: Colors.black38),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 26),
            child: SmoothPageIndicator(
              controller: pageController,
              count: ticketSummary.tickets.length,
              effect: const WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Colors.white,
                dotColor: Colors.white38,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TicketEventInfoQR extends StatelessWidget {
  const TicketEventInfoQR({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h * 0.5,
      width: context.w * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Image.network(
              'https://picsum.photos/id/10/1024/1024',
              fit: BoxFit.cover,
              width: context.w * 0.7,
              height: context.h * 0.25,
            ),
          ),
          Text(
            event.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 2,
            ),
          ),
          const Text(
            '-  -  -  -  -  -  -  -  -  -  -  -  -',
            style: TextStyle(fontSize: 18, color: Colors.black12),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Helpers.formatDate(event.date.toString()),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  event.time,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: context.h * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Venue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Seat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event.venue,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const Text(
                  'No seat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class TicketQR extends StatelessWidget {
  const TicketQR({
    Key? key,
    required this.reference,
  }) : super(key: key);

  final String reference;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h * 0.25,
      width: context.w * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
        child: SfBarcodeGenerator(
          symbology: QRCode(),
          value: reference,
        ),
      ),
    );
  }
}

class TicketShapeClipper extends CustomClipper<Path> {
  final double width;
  final double height;

  TicketShapeClipper({required this.width, required this.height});

  @override
  Path getClip(Size size) {
    final containerPath = Path();
    final rightPath = Path();
    final leftPath = Path();

    final container = containerPath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width,
          height,
        ),
      );

    final right = rightPath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          width * 0.67,
          0,
          width,
          height * 0.01,
          topLeft: const Radius.circular(10),
          bottomLeft: const Radius.circular(10),
        ),
      )
      ..close();

    final left = leftPath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width * 0.03,
          height * 0.01,
          topRight: const Radius.circular(10),
          bottomRight: const Radius.circular(10),
        ),
      )
      ..close();

    final newPath = Path.combine(PathOperation.difference, Path.combine(PathOperation.difference, container, right), left);

    return newPath;
  }

  @override
  bool shouldReclip(TicketShapeClipper oldClipper) => true;
}
