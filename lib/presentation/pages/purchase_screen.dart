import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/extensions/extensions.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/bloc/purchase_bloc.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/presentation/widgets/avatar.dart';
import 'package:ui/presentation/widgets/button.dart';

class PurchaseScreen extends StatelessWidget {
  const PurchaseScreen({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: customAppBar(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PurchaseEventCard(url: 'https://picsum.photos/id/1/1024/1024', event: event),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: PurchaseTicketCard(),
            ),
          ],
        ),
      ),
    );
  }

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

  PreferredSizeWidget customAppBar(BuildContext context) => AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(event.title),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: const Icon(
              CupertinoIcons.ellipsis_vertical,
              size: 26,
            ),
            onPressed: () => Logger.debug('todo more actions'),
          ),
        ],
        leading: IconButton(
          padding: const EdgeInsets.only(left: 16),
          icon: const Icon(
            CupertinoIcons.left_chevron,
            size: 26,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      );
}

class PurchaseEventCard extends StatelessWidget {
  const PurchaseEventCard({
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
                        children: const [
                          Text(
                            'UNIVERSAL MUSIC SPAIN',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              height: 2,
                            ),
                          ),
                          Text(
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
    );
  }
}

class PurchaseShapeClipper extends CustomClipper<Path> {
  final double width;
  final double height;

  PurchaseShapeClipper({required this.width, required this.height});

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
  bool shouldReclip(PurchaseShapeClipper oldClipper) => true;
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
          clipper: PurchaseShapeClipper(width: context.w, height: context.h),
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

class PurchaseTicketCard extends StatelessWidget {
  PurchaseTicketCard({Key? key}) : super(key: key);

  late PurchaseBloc _purchaseBloc;

  @override
  Widget build(BuildContext context) {
    _purchaseBloc = BlocProvider.of<PurchaseBloc>(context);
    return Container(
      width: context.w,
      height: context.h * 0.12,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 8, top: 6),
            child: BlocBuilder<PurchaseBloc, int>(
              builder: (context, ticketCounter) => Row(
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
                    onPressed: _decrementTicketCounter,
                    icon: const Icon(CupertinoIcons.minus_circle_fill),
                    padding: const EdgeInsets.only(top: 8, right: 10),
                    constraints: const BoxConstraints(),
                    iconSize: 18,
                    color: ticketCounter == 1 ? Colors.black26 : Colors.black87,
                  ),
                  _counterText(ticketCounter),
                  IconButton(
                    onPressed: _incrementTicketCounter,
                    icon: const Icon(CupertinoIcons.add_circled_solid),
                    padding: const EdgeInsets.only(top: 8, left: 10),
                    constraints: const BoxConstraints(),
                    iconSize: 18,
                    color: ticketCounter == 4 ? Colors.black26 : Colors.black87,
                  ),
                ],
              ),
            ),
          ),
          Button(
            text: 'Buy',
            width: context.w * 0.4,
            onPressed: () => Logger.debug('buy ${_purchaseBloc.state} tickets'),
          ),
        ],
      ),
    );
  }

  SizedBox _counterText(int ticketCounter) {
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

  void _decrementTicketCounter() {
    _purchaseBloc.decrementTicketCounter();
  }

  void _incrementTicketCounter() {
    _purchaseBloc.incrementTicketCounter();
  }
}
