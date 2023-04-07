import 'package:flutter_test/flutter_test.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';

void main() {
  test('Test randomPictureUrl()', () {
    String url = Helpers.randomPictureUrl();

    // Assert that the URL starts with 'https://picsum.photos/seed/'
    // followed by an integer between 0 and 999, and ends with '/300/300'
    RegExp regex = RegExp(r"https://picsum.photos/seed/[0-9]{1,3}/300/300");
    expect(regex.hasMatch(url), true);
  });

  test('Test randomDateTime()', () {
    DateTime result = Helpers.randomDateTime();

    // Assert that the returned DateTime is within a valid range
    DateTime currentDate = DateTime.now();
    DateTime minDate = currentDate.subtract(const Duration(seconds: 200000));
    DateTime maxDate = currentDate;
    expect(result.isAfter(minDate), true);
    expect(result.isBefore(maxDate), true);
  });

  group('CodeGenerator', () {
    test('generateRandomCode() should generate a random code of length 5', () {
      final code = Helpers.randomCode();
      expect(code.length, equals(5));
    });

    test('_generateRandomCode() should generate a code containing only digits',
        () {
      final code = Helpers.randomCode();
      final isDigitsOnly = int.tryParse(code) != null;
      expect(isDigitsOnly, isTrue);
    });

    test('_generateRandomCode() should generate unique codes', () {
      final code1 = Helpers.randomCode();
      final code2 = Helpers.randomCode();
      expect(code1, isNot(equals(code2)));
    });
  });
}
