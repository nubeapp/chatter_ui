import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:ui/domain/entities/ticket/ticket_summary.dart';
import 'package:ui/domain/services/ticket_service_interface.dart';
import 'package:ui/extensions/extensions.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/pages/ticket_info_screen.dart';
import 'package:ui/presentation/styles/logger.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  final _ticketService = GetIt.instance<ITicketService>();

  late Future<List<TicketSummary>> _tickets;

  @override
  void initState() {
    super.initState();
    _tickets = _fetchTickets();
  }

  Future<List<TicketSummary>> _fetchTickets() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedTickets = sharedPreferences.getString('tickets');
    if (cachedTickets != null) {
      final tickets = _decodeTicketSummaryList(cachedTickets);
      return tickets;
    } else {
      final tickets = await _ticketService.getTicketsByUserId();
      await sharedPreferences.setString('tickets', _encodeTicketSummaryList(tickets));
      return tickets;
    }
  }

  String _encodeTicketSummaryList(List<TicketSummary> tickets) {
    final List<Map<String, dynamic>> ticketListJson = tickets.map((ticket) => ticket.toJson()).toList();
    return jsonEncode(ticketListJson);
  }

  List<TicketSummary> _decodeTicketSummaryList(String json) {
    try {
      final List<dynamic> ticketListJson = jsonDecode(json);
      return ticketListJson.map<TicketSummary>((ticketJson) => TicketSummary.fromJson(ticketJson as Map<String, dynamic>)).toList();
    } catch (e) {
      Logger.error(e.toString());
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget customAppBar() => AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Tickets'),
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

    return Container(
      decoration: backgroundGradient(),
      child: Scaffold(
        appBar: customAppBar(),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<TicketSummary>>(
          future: _tickets,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final tickets = snapshot.data!;
              if (tickets.isNotEmpty) {
                return TicketsListView(tickets: tickets);
              } else {
                return const Center(
                  child: Text(
                    '☹️ There are no tickets...',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching tickets'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
          },
        ),
      ),
    );
  }
}

class TicketsListView extends StatelessWidget {
  const TicketsListView({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  final List<TicketSummary> tickets;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicketInfoScreen(ticketSummary: tickets[index]))),
            child: TicketEventCard(
              ticketSummary: tickets[index],
              url: 'https://picsum.photos/id/${index + 10}/1024/1024',
            ),
          ),
        );
      },
    );
  }
}

class TicketEventCard extends StatelessWidget {
  const TicketEventCard({
    Key? key,
    required this.ticketSummary,
    required this.url,
  }) : super(key: key);

  final TicketSummary ticketSummary;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h * 0.175,
      width: context.w,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                width: context.h * 0.15,
                height: context.h * 0.15,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ticketSummary.event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const Text(
                    '-  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -',
                    style: TextStyle(fontSize: 12, color: Colors.black26),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Date',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          'Time',
                          style: TextStyle(
                            fontSize: 12,
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
                          Helpers.formatDate(ticketSummary.event.date.toString()),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          ticketSummary.event.time,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.h * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Venue',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ticketSummary.event.venue,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        if (ticketSummary.tickets.length > 1)
                          Row(
                            children: [
                              Text(
                                ticketSummary.tickets.length.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(
                                width: context.w * 0.01,
                              ),
                              const Icon(
                                CupertinoIcons.ticket,
                                size: 18,
                                color: Colors.black54,
                              ),
                            ],
                          )
                        //
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
