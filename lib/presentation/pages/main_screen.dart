import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/domain/services/favourite_service_interface.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/pages/pages.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/extensions/extensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _eventService = GetIt.instance<IEventService>();

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget customAppBar() => AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(CupertinoIcons.globe),
              SizedBox(
                width: context.w * 0.02,
              ),
              GestureDetector(
                onTap: () => Logger.debug('todo location'),
                behavior: HitTestBehavior.opaque,
                child: const Text('Madrid, Spain'),
              ),
            ],
          ),
          actions: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              padding: const EdgeInsets.only(right: 16),
              icon: const Icon(
                CupertinoIcons.tickets,
                size: 26,
              ),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                settings: const RouteSettings(name: '/ticket_screen'),
                builder: (context) => const TicketScreen(),
              )),
            ),
          ],
          leading: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            padding: const EdgeInsets.only(left: 16),
            icon: const Icon(
              CupertinoIcons.bell,
              size: 26,
            ),
            onPressed: () => Logger.debug('todo notifications'),
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

    Future<EventResults> fetchEvents() async {
      final favouriteEventsFuture = _eventService.getFavouriteEventsByUserId();
      final eventsFuture = _eventService.getEvents();

      final favouriteEvents = await favouriteEventsFuture;
      final events = await eventsFuture;

      return EventResults(favouriteEventIds: favouriteEvents.map((event) => event.id!).toList(), events: events);
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: backgroundGradient(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: customAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Plan your best event',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.h * 0.005, bottom: context.h * 0.03),
                  child: const Text(
                    'Explore the best events around you',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: context.h * 0.28,
                  child: FutureBuilder<EventResults>(
                    future: fetchEvents(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(width: 24),
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: const Color(0xFF507188),
                              highlightColor: const Color(0xFFABB7C1),
                              child: const CarouselEventCardSkeleton(),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text('Error fetching events'),
                        );
                      } else {
                        final eventResults = snapshot.data!;
                        final events = eventResults.events;
                        if (events.isNotEmpty) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(width: 24),
                            scrollDirection: Axis.horizontal,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              return CarouselEventCard(
                                url: 'https://picsum.photos/id/${index + 10}/1024/1024',
                                event: events[index],
                                favouriteEventIds: eventResults.favouriteEventIds,
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              '☹️ There are no events available...',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                      }
                    },
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

class EventResults {
  final List<int> favouriteEventIds;
  final List<Event> events;

  EventResults({required this.favouriteEventIds, required this.events});
}

class CarouselEventCardSkeleton extends StatelessWidget {
  const CarouselEventCardSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w * 0.7 - 24,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.black38,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: context.w * 0.7 - 24,
              height: context.h * 0.18,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.black38,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: context.w * 0.7 - 24,
              height: context.h * 0.02,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.black38,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: context.w * 0.35 - 24,
                  height: context.h * 0.02,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black38,
                  ),
                ),
                Container(
                  width: context.w * 0.25 - 24,
                  height: context.h * 0.02,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black38,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselEventCard extends StatefulWidget {
  const CarouselEventCard({
    Key? key,
    required this.url,
    required this.event,
    required this.favouriteEventIds,
  }) : super(key: key);

  final String url;
  final Event event;
  final List<int> favouriteEventIds;

  @override
  State<CarouselEventCard> createState() => _CarouselEventCardState();
}

class _CarouselEventCardState extends State<CarouselEventCard> {
  final _favouriteService = GetIt.instance<IFavouriteService>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          settings: const RouteSettings(name: '/event'),
          builder: (context) => EventScreen(
                event: widget.event,
                url: widget.url,
              ))),
      child: Container(
        width: context.w * 0.7 - 24,
        height: context.h * 0.28,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: ClipPath(
                clipper: CarouselEventCardShapeClipper(width: context.w, height: context.h),
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                  width: context.w,
                  height: context.h,
                ),
              ),
            ),
            Positioned(
              top: context.h * 0.22,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 10,
                      child: Text(
                        widget.event.title,
                        style: const TextStyle(
                          fontSize: 18,
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
                        widget.event.time,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: context.h * 0.25,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Helpers.formatStringDate(widget.event.date.toString()),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
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
              ),
            ),
            Positioned(
              top: context.h * 0.155,
              right: 0,
              child: GestureDetector(
                onTap: () async {
                  if (widget.favouriteEventIds.contains(widget.event.id)) {
                    await _favouriteService.deleteFromFavourites(widget.event.id!);
                    widget.favouriteEventIds.remove(widget.event.id!);
                  } else {
                    await _favouriteService.addToFavourites(widget.event.id!);
                    widget.favouriteEventIds.add(widget.event.id!);
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    width: context.w * 0.115,
                    height: context.h * 0.055,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(18)),
                    ),
                    child: widget.favouriteEventIds.contains(widget.event.id)
                        ? const Icon(
                            CupertinoIcons.heart_solid,
                            color: Colors.red,
                          )
                        : const Icon(
                            CupertinoIcons.heart,
                            color: Colors.black,
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselEventCardShapeClipper extends CustomClipper<Path> {
  final double width;
  final double height;

  CarouselEventCardShapeClipper({required this.width, required this.height});

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
          width * 0.6,
          height * 0.2,
          topRight: const Radius.circular(15),
          bottomRight: const Radius.circular(20),
          topLeft: const Radius.circular(20),
        ),
      );

    final favourite = favouritePath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          width * 0.47,
          height * 0.14,
          width * 0.6,
          height * 0.3,
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
  bool shouldReclip(CarouselEventCardShapeClipper oldClipper) => true;
}
