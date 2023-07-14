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

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final _eventService = GetIt.instance<IEventService>();

  void _rebuildParent() {
    setState(() {
      Logger.debug('I am rebuilding!');
    });
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Container(
        decoration: backgroundGradient(),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.h * 0.28,
                    child: FutureBuilder<List<Event>>(
                      future: _eventService.getFavouriteEventsByUserId(),
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
                                child: const CarouselEventCardSkeletonFavourite(),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error fetching events'),
                          );
                        } else {
                          final events = snapshot.data!;
                          if (events.isNotEmpty) {
                            return ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(width: 24),
                              scrollDirection: Axis.horizontal,
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                return CarouselEventCardFavourite(
                                  url: 'https://picsum.photos/id/${index + 10}/1024/1024',
                                  event: events[index],
                                  callback: _rebuildParent,
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
      ),
    );
  }
}

class EventResultsFavourite {
  final List<int> favouriteEventIds;
  final List<Event> events;

  EventResultsFavourite({required this.favouriteEventIds, required this.events});
}

class CarouselEventCardSkeletonFavourite extends StatelessWidget {
  const CarouselEventCardSkeletonFavourite({
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

class CarouselEventCardFavourite extends StatelessWidget {
  CarouselEventCardFavourite({
    Key? key,
    required this.url,
    required this.event,
    required this.callback,
  }) : super(key: key);

  final String url;
  final Event event;
  final VoidCallback callback;

  final _favouriteService = GetIt.instance<IFavouriteService>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          settings: const RouteSettings(name: '/event'),
          builder: (context) => EventScreen(
                event: event,
                url: url,
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
                clipper: CarouselEventCardShapeClipperFavourite(width: context.w, height: context.h),
                child: Image.network(
                  url,
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
                        event.title,
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
                        event.time,
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
                      Helpers.formatStringDate(event.date.toString()),
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
                  await _favouriteService.deleteFromFavourites(event.id!);
                  callback();
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
                    child: const Icon(
                      CupertinoIcons.heart_solid,
                      color: Colors.red,
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

class CarouselEventCardShapeClipperFavourite extends CustomClipper<Path> {
  final double width;
  final double height;

  CarouselEventCardShapeClipperFavourite({required this.width, required this.height});

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
  bool shouldReclip(CarouselEventCardShapeClipperFavourite oldClipper) => true;
}
