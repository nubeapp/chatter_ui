import 'dart:math' show Random;

import 'package:intl/intl.dart';

abstract class Helpers {
  static final random = Random();

  /// Public functions

  static String randomPictureUrl() {
    final randomInt = random.nextInt(1000);
    return 'https://picsum.photos/seed/$randomInt/300/300';
  }

  static DateTime randomDateTime() {
    final currentDate = DateTime.now();
    return currentDate.subtract(Duration(seconds: random.nextInt(200000)));
  }

  static String randomNumericCode(int length) {
    const charset = '0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
  }

  static String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);

    String dayOfWeek = DateFormat('EEE').format(dateTime);
    String dayOfMonth = DateFormat('d').format(dateTime);
    String month = _getAbbreviatedMonthName(dateTime.month);

    return '$dayOfWeek, $dayOfMonth $month';
  }

  static String _getAbbreviatedMonthName(int month) {
    List<String> months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month];
  }
}
