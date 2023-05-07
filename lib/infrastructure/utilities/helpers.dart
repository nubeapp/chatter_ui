import 'dart:math' show Random;

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
    return String.fromCharCodes(Iterable.generate(
        length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
  }

  static String formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String day = dateTime.day.toString();
    String month = _getMonthName(dateTime.month);
    String year = dateTime.year.toString();
    // String hour = dateTime.hour.toString().padLeft(2, '0');
    // String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$day $month $year';
  }

  static String randomReference(int length) {
    const charset = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
  }

  static List<String> generateRandomReferenceListByLimit(int limit) {
    final Set<String> uniqueCodes = {};

    while (uniqueCodes.length < limit) {
      final code = randomReference(20); // or any length you want
      uniqueCodes.add(code);
    }

    return uniqueCodes.toList();
  }

  /// Private functions

  static String _getMonthName(int monthNumber) {
    switch (monthNumber) {
      case 1:
        return 'jan';
      case 2:
        return 'feb';
      case 3:
        return 'mar';
      case 4:
        return 'apr';
      case 5:
        return 'may';
      case 6:
        return 'jun';
      case 7:
        return 'jul';
      case 8:
        return 'aug';
      case 9:
        return 'sep';
      case 10:
        return 'oct';
      case 11:
        return 'nov';
      case 12:
        return 'dec';
      default:
        return '';
    }
  }
}
