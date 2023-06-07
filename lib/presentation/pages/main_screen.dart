import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/pages/pages.dart';
import 'package:ui/presentation/pages/ticket_screen.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/extensions/extensions.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final fakeEvents = [
    Event(id: 1, title: 'Bad Bunny Tour', date: DateFormat("dd-MM-yyyy").parse('07-12-2023'), time: '18.00', venue: 'Wizink Center', organizationId: 1),
    Event(id: 2, title: 'Lola Indigo Tour', date: DateFormat("dd-MM-yyyy").parse('14-12-2023'), time: '18.00', venue: 'Wizink Center', organizationId: 1),
    Event(
        id: 3,
        title: 'Antonio Díaz: El Mago Pop',
        date: DateFormat("dd-MM-yyyy").parse('14-12-2023'),
        time: '20.00',
        venue: 'Teatro Apollo',
        organizationId: 2),
    Event(id: 4, title: 'Blake en concierto', date: DateFormat("dd-MM-yyyy").parse('14-02-2023'), time: '21.00', venue: 'Sala8', organizationId: 3),
  ];

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
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TicketScreen())),
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

    return Container(
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
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          width: 24,
                        ),
                    scrollDirection: Axis.horizontal,
                    itemCount: fakeEvents.length,
                    itemBuilder: (context, index) {
                      // var random = Random();
                      // int id = random.nextInt(100) + 1;
                      return CarouselEventCard(
                        url: 'https://picsum.photos/id/${index + 10}/1024/1024',
                        event: fakeEvents[index],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarouselEventCard extends StatelessWidget {
  const CarouselEventCard({
    Key? key,
    required this.url,
    required this.event,
  }) : super(key: key);

  final String url;
  final Event event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
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
                clipper: CarouselEventCardShapeClipper(width: context.w, height: context.h),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      flex: 10,
                      child: Text(
                        'A world tour event!',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
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
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black54,
                          letterSpacing: 1,
                        ),
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
