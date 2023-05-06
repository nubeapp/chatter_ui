import 'package:flutter/material.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/presentation/styles/logger.dart';

class EventTile extends StatelessWidget {
  const EventTile({Key? key, required this.event, required this.image})
      : super(key: key);

  final Event event;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle onTap event here
        Logger.debug('tapped');
      },
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 36, 34, 34),
              Theme.of(context).backgroundColor,
            ],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              height: 400,
              top: -50,
              left: -50,
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.35, 1.0],
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                ).createShader(bounds),
                blendMode: BlendMode.dstIn,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      event.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
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
