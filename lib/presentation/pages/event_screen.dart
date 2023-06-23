import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/services/ticket_service_interface.dart';
import 'package:ui/extensions/extensions.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/bloc/ticket_counter/ticket_counter_bloc.dart';
import 'package:ui/presentation/bloc/ticket_counter/ticket_counter_state.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/presentation/widgets/avatar.dart';
import 'package:ui/presentation/widgets/button.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({
    super.key,
    required this.event,
    required this.url,
  });

  final Event event;
  final String url;

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
    PreferredSizeWidget customAppBar() => AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(event.title),
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: const EdgeInsets.only(right: 16),
              icon: const Icon(
                CupertinoIcons.ellipsis_vertical,
                size: 26,
              ),
              onPressed: () => Logger.debug('todo more actions'),
            ),
          ],
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(
              CupertinoIcons.left_chevron,
              size: 26,
            ),
            onPressed: () {
              BlocProvider.of<TicketCounterBloc>(context).resetTicketCounter();
              Navigator.of(context).pop();
            },
          ),
        );

    return Container(
      decoration: backgroundGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: customAppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: EventCard(url: url, event: event),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: EventTicketCounterCard(event: event),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.url,
    required this.event,
  }) : super(key: key);

  final String url;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w,
      height: context.h * 0.7,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.white],
              stops: [0.92, 1.0], // 10% purple, 80% transparent, 10% purple
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 10,
                        child: Text(
                          event.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: 0.5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 4,
                        child: Text(
                          event.time,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        flex: 10,
                        child: Text(
                          'A world tour event!',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                            letterSpacing: 0.5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: Text(
                          Helpers.formatDate(event.date.toString()),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Flexible(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.black45,
                              size: 16,
                            ),
                          )),
                      Flexible(
                        flex: 10,
                        child: Text(
                          event.venue,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black45,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: EventStack(url: url),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Avatar.medium(
                        url: Helpers.randomPictureUrl(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event.organization!.name.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                                height: 2,
                              ),
                            ),
                            const Text(
                              '473 Followers',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Button(
                          text: 'Follow',
                          width: context.w * 0.2,
                          onPressed: () => Logger.debug('follow'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
                  child: SizedBox(
                    width: context.w * 0.9 - 12,
                    child: Text(
                      loremIpsum(words: 100),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventShapeClipper extends CustomClipper<Path> {
  final double width;
  final double height;

  EventShapeClipper({required this.width, required this.height});

  @override
  Path getClip(Size size) {
    final imagePath = Path();
    final favouritePath = Path();
    final tagPath = Path();

    final image = imagePath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width * 0.897,
          height * 0.4,
          topRight: const Radius.circular(15),
          bottomRight: const Radius.circular(20),
          topLeft: const Radius.circular(20),
        ),
      );

    final favourite = favouritePath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          width * 0.77,
          height * 0.34,
          width,
          height,
          topLeft: const Radius.circular(20),
        ),
      )
      ..close();

    final tag = tagPath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width * 0.2,
          height * 0.04,
          topLeft: const Radius.circular(20),
          bottomRight: const Radius.circular(20),
        ),
      )
      ..close();

    final newPath = Path.combine(PathOperation.difference, Path.combine(PathOperation.difference, image, favourite), tag);

    return newPath;
  }

  @override
  bool shouldReclip(EventShapeClipper oldClipper) => true;
}

class EventStack extends StatelessWidget {
  const EventStack({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: EventShapeClipper(width: context.w, height: context.h),
          child: Image.network(
            url,
            fit: BoxFit.cover,
            width: context.w,
            height: context.h * 0.4,
          ),
        ),
        Container(
          width: context.w * 0.19,
          height: context.h * 0.0355,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(18)),
          ),
          child: const Center(
            child: Text(
              'Music',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        Positioned(
          top: context.h * 0.345,
          right: -8,
          child: GestureDetector(
            onTap: () => Logger.debug('todo favourite'),
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Container(
                width: context.w * 0.115,
                height: context.h * 0.055,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.05),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(18)),
                ),
                child: const Icon(CupertinoIcons.heart),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class EventTicketCounterCard extends StatefulWidget {
  const EventTicketCounterCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  final Event event;

  @override
  State<EventTicketCounterCard> createState() => _EventTicketCounterCardState();
}

class _EventTicketCounterCardState extends State<EventTicketCounterCard> {
  final _ticketService = GetIt.instance<ITicketService>();
  int _nUserTickets = -1;
  int _nTicketsAvailable = -1;
  bool _isLoading = true;
  int _maxTicketsCanBuy = 4;

  @override
  void initState() {
    super.initState();
    _fetchTicketData();
  }

  Future<void> _fetchTicketData() async {
    try {
      final availableTickets = await _ticketService.getTicketsAvailableByEventId(widget.event.id!);
      final userTickets = await _ticketService.getTicketsByUserIdEventId(widget.event.id!);
      setState(() {
        _nTicketsAvailable = availableTickets.tickets.length;
        _nUserTickets = userTickets.tickets.length;
        _maxTicketsCanBuy -= _nUserTickets;
        _isLoading = false;
      });
    } catch (e) {
      Logger.error('Error fetching ticket data: ${e.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TicketCounterBloc, TicketCounterState>(
      builder: (context, state) {
        final ticketCounterBloc = BlocProvider.of<TicketCounterBloc>(context);
        return Container(
          width: context.w,
          height: context.h * 0.12,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
            color: Colors.white,
          ),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator()) // Show a loading indicator while fetching data
              : _nTicketsAvailable >= 1
                  ? _maxTicketsCanBuy == 0
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 6),
                              child: _buildContent(context, state),
                            ),
                            Button(
                              text: 'Buy',
                              width: context.w * 0.4,
                              onPressed: () => Logger.debug('Ticket limit reached!'),
                              blocked: true,
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 6),
                              child: _buildContent(context, state),
                            ),
                            Button(
                              text: 'Buy',
                              width: context.w * 0.4,
                              onPressed: () => _buyTickets(ticketCounterBloc.ticketCounter, context),
                            ),
                          ],
                        )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 6),
                          child: _buildContentFixed(context),
                        ),
                        Button(
                          text: 'Buy',
                          width: context.w * 0.4,
                          onPressed: () => Logger.debug('There are no tickets available'),
                          blocked: true,
                        ),
                      ],
                    ),
        );
      },
    );
  }

  void _buyTickets(int counter, BuildContext context) async {
    try {
      Order order = Order(eventId: widget.event.id, quantity: counter);
      final tickets = await _ticketService.buyTickets(order);
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.remove('tickets');
    } catch (e) {
      Logger.error('Error buying tickets: ${e.toString()}');
    }

    // Check return and go to successful screen or error screen
  }

  Widget _buildContent(BuildContext context, TicketCounterState state) {
    if (state is TicketCounterUpdatedState) {
      return _buildContentRow(context, state.ticketCounter);
    } else {
      return _buildContentRow(context, 1); // Default initial state
    }
  }

  Widget _buildContentRow(BuildContext context, int ticketCounter) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'General - ',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            height: 2,
          ),
        ),
        const Text(
          '80 €',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            height: 2,
          ),
        ),
        SizedBox(
          width: context.w * 0.4,
        ),
        IconButton(
          onPressed: () {
            // Tickets quantity should be 1 or more
            if (ticketCounter - 1 >= 1) {
              context.read<TicketCounterBloc>().decrementTicketCounter();
            }
          },
          icon: const Icon(CupertinoIcons.minus_circle_fill),
          padding: const EdgeInsets.only(top: 8, right: 10),
          constraints: const BoxConstraints(),
          iconSize: 18,
          color: ticketCounter == 1 ? Colors.black26 : Colors.black87,
        ),
        _ticketCounterText(_maxTicketsCanBuy == 0 ? 0 : ticketCounter),
        IconButton(
          onPressed: () {
            // Limit to 4 tickets per user
            if (ticketCounter + 1 <= _maxTicketsCanBuy) {
              context.read<TicketCounterBloc>().incrementTicketCounter();
            }
          },
          icon: const Icon(CupertinoIcons.add_circled_solid),
          padding: const EdgeInsets.only(top: 8, left: 10),
          constraints: const BoxConstraints(),
          iconSize: 18,
          color: ticketCounter >= _maxTicketsCanBuy ? Colors.black26 : Colors.black87,
        ),
      ],
    );
  }

  Widget _buildContentFixed(BuildContext context) {
    return const Text(
      'Tickets are not available for the event',
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        height: 2,
      ),
    );
  }

  SizedBox _ticketCounterText(int ticketCounter) {
    return SizedBox(
      width: 12,
      child: Text(
        ticketCounter.toString(),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
          height: 2,
        ),
      ),
    );
  }
}
