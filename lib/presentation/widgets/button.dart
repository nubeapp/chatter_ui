import 'package:flutter/material.dart';
import 'package:ui/extensions/extensions.dart';

@immutable
class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.onPressed,
    required this.width,
    this.blocked = false,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final double width;
  final bool blocked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: context.h * 0.05,
      child: Material(
        color: blocked ? Colors.black26 : Colors.black, // Apply the background color here
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: InkWell(
          onTap: blocked ? null : onPressed,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
