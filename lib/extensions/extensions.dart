import 'package:flutter/material.dart';
import 'package:ui/domain/entities/event.dart';

extension SizeExtension on BuildContext {
  double get w => MediaQuery.of(this).size.width;
  double get h => MediaQuery.of(this).size.height;
}

extension StringExtension on String {
  bool equals(String other) {
    return this == other;
  }
}

extension EventExtension on Event {
  dynamic operator [](String propertyName) => propertyName;
}
