import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/domain/services/favourite_service_interface.dart';
import 'package:ui/presentation/pages/pages.dart';
import 'package:ui/extensions/extensions.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final _eventService = GetIt.instance<IEventService>();
  List<int> favouriteEventIds = [];

  Future<List<Event>> fetchFavouriteEvents() async {
    final favouriteEventsFuture = _eventService.getFavouriteEventsByUserId();
    final favouriteEvents = await favouriteEventsFuture;
    favouriteEventIds = favouriteEvents.map((event) => event.id!).toList();
    return favouriteEventsFuture;
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
                    height: context.h * 0.9,
                    child: FutureBuilder<List<Event>>(
                      future: fetchFavouriteEvents(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListView.separated(
                            separatorBuilder: (context, index) => const SizedBox(height: 18),
                            scrollDirection: Axis.vertical,
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
                            child: Text('Error fetching favourite events'),
                          );
                        } else {
                          final events = snapshot.data!;
                          if (events.isNotEmpty) {
                            return ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(height: 18),
                              scrollDirection: Axis.vertical,
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                return CarouselEventCardFavourite(
                                  url: 'https://picsum.photos/id/${index + 10}/1024/1024',
                                  event: events[index],
                                  favouriteEventIds: favouriteEventIds,
                                  // callback: _rebuildParent,
                                );
                              },
                            );
                          } else {
                            return const Center(
                              child: Text(
                                'You have no favourite events...',
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

class CarouselEventCardSkeletonFavourite extends StatelessWidget {
  const CarouselEventCardSkeletonFavourite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w * 0.9 - 24,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.black38,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: context.w * 0.9 - 24,
              height: context.h * 0.08,
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

class CarouselEventCardFavourite extends StatefulWidget {
  const CarouselEventCardFavourite({
    Key? key,
    required this.url,
    required this.event,
    required this.favouriteEventIds,
  }) : super(key: key);

  final String url;
  final Event event;
  final List<int> favouriteEventIds;

  @override
  State<CarouselEventCardFavourite> createState() => _CarouselEventCardFavouriteState();
}

class _CarouselEventCardFavouriteState extends State<CarouselEventCardFavourite> {
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
        height: context.h * 0.14,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
          color: Colors.white,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.transparent, Colors.white],
                    stops: [0.0, 1], // Adjust stops to control the fade effect
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: ClipPath(
                  clipper: CarouselEventCardShapeClipperFavourite(width: context.w, height: context.h),
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            Positioned(
              top: context.h * 0.098,
              right: context.w * 0.035,
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
                  // callback();
                },
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
            Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: FittedBox(
                  fit: BoxFit.none,
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xBAFFFFFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
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

    final image = imagePath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          width * 0.915,
          height * 0.2,
          topRight: const Radius.circular(15),
          bottomRight: const Radius.circular(20),
          topLeft: const Radius.circular(20),
        ),
      );

    final favourite = favouritePath
      ..addRRect(
        RRect.fromLTRBAndCorners(
          width * 0.8,
          height * 0.08,
          width,
          height,
          topLeft: const Radius.circular(20),
        ),
      )
      ..close();

    final newPath = Path.combine(PathOperation.difference, image, favourite);

    return newPath;
  }

  @override
  bool shouldReclip(CarouselEventCardShapeClipperFavourite oldClipper) => true;
}
