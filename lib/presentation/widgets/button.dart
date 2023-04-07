import 'package:flutter/material.dart';

@immutable
class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 70,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}
