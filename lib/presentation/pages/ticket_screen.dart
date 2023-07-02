import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
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
  final _limit = 15;
  int _offset = 0;
  bool _isLoading = false;
  bool _ticketsRemaining = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tickets = _fetchTickets();

    // Add a listener to the scroll controller
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // Dispose the scroll controller when the widget is disposed
    _scrollController.dispose();
    super.dispose();
  }

  Future<List<TicketSummary>> _fetchTickets() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final cachedTickets = sharedPreferences.getString('tickets');
    if (cachedTickets != null) {
      final tickets = _decodeTicketSummaryList(cachedTickets);
      return tickets;
    } else {
      final tickets = await _ticketService.getTicketsByUserId(_limit, _offset);
      await sharedPreferences.setString('tickets', _encodeTicketSummaryList(tickets));
      return tickets;
    }
  }

  // Fetch the next set of tickets
  Future<void> _loadNextTickets() async {
    if (_isLoading) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      _offset += _limit; // Increment the offset for the next fetch
      final nextTickets = await _ticketService.getTicketsByUserId(_limit, _offset);
      if (nextTickets.isEmpty || nextTickets.length < _limit) {
        _ticketsRemaining = false;
      }
      final allTickets = await _tickets;

      // Append the new tickets to the existing list
      final updatedTickets = [...allTickets, ...nextTickets];

      setState(() {
        _tickets = Future.value(updatedTickets);
        _isLoading = false;
      });
    } catch (e) {
      // Handle the error
      Logger.error('Error loading next tickets: ${e.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _scrollListener() {
    // Check if the user has reached the bottom of the scroll
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent - 20 && !_scrollController.position.outOfRange) {
      if (_ticketsRemaining) {
        _loadNextTickets();
      }
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
                return TicketsListView(tickets: tickets, scrollController: _scrollController);
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
              return Shimmer.fromColors(
                baseColor: const Color(0xFF507188),
                highlightColor: const Color(0xFFABB7C1),
                child: const TicketsListViewSkeleton(),
              );
            }
          },
        ),
      ),
    );
  }
}

class TicketsListViewSkeleton extends StatelessWidget {
  const TicketsListViewSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: TicketEventCardSkeleton(),
        );
      },
    );
  }
}

class TicketEventCardSkeleton extends StatelessWidget {
  const TicketEventCardSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h * 0.175,
      width: context.w,
      decoration: const BoxDecoration(
        color: Colors.black38,
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
            Container(
              width: context.w * 0.34,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: Colors.black38,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Container(
                      width: context.w * 0.3,
                      height: context.h * 0.02,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: context.w * 0.15,
                          height: context.h * 0.01,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black38,
                          ),
                        ),
                        Container(
                          width: context.w * 0.2,
                          height: context.h * 0.01,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black38,
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
                        Container(
                          width: context.w * 0.1,
                          height: context.h * 0.01,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black38,
                          ),
                        ),
                        Container(
                          width: context.w * 0.25,
                          height: context.h * 0.01,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.h * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: context.w * 0.2,
                          height: context.h * 0.01,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black38,
                          ),
                        ),
                        Container(
                          width: context.w * 0.2,
                          height: context.h * 0.01,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black38,
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
                        Container(
                          width: context.w * 0.2,
                          height: context.h * 0.01,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black38,
                          ),
                        ),
                        Container(
                          width: context.w * 0.1,
                          height: context.h * 0.01,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            color: Colors.black38,
                          ),
                        ),
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

class TicketsListView extends StatelessWidget {
  const TicketsListView({
    Key? key,
    required this.tickets,
    required this.scrollController,
  }) : super(key: key);

  final List<TicketSummary> tickets;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              settings: const RouteSettings(name: '/ticket_info'),
              builder: (context) => TicketInfoScreen(ticketSummary: tickets[index]),
            )),
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
                          Helpers.formatStringDate(ticketSummary.event.date.toString()),
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
