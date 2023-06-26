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
    return String.fromCharCodes(Iterable.generate(length, (_) => charset.codeUnitAt(random.nextInt(charset.length))));
  }

  static String formatDate(String dateTimeString) {
    List<String> parts = dateTimeString.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    String abbreviatedMonth = _getAbbreviatedMonthName(month);

    return '$abbreviatedMonth $day, $year';
  }

  static String formatWithTwoDecimals(double value) {
    return value.toStringAsFixed(2);
  }

  static String _getAbbreviatedMonthName(int month) {
    List<String> months = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month];
  }
}
