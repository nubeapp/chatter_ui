import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  const CustomIconButton.search({
    Key? key,
    this.icon = CupertinoIcons.search,
    required this.onPressed,
  }) : super(key: key);

  const CustomIconButton.back({
    Key? key,
    this.icon = CupertinoIcons.back,
  })  : onPressed = _defaultOnPressed,
        super(key: key);

  final IconData icon;
  final void Function()? onPressed;

  static BuildContext? _context;

  static void _defaultOnPressed() {
    if (_context != null) {
      Navigator.of(_context!).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 30,
      ),
    );
  }
}
