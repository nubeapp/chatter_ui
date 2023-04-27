import 'package:flutter/material.dart';

class EventTile extends StatelessWidget {
  const EventTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
                'badbunny.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Row(
            children: [
              Text('hola'),
              Text('hello'),
            ],
          )
        ],
      ),
    );
  }
}
