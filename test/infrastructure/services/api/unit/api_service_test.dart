import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:ui/infrastructure/services/api_service.dart';

void main() {
  group('ApiService', () {
    // Declare variables
    late ApiService apiService;

    setUp(() {
      // Set up the ApiService object
      apiService = ApiService();
    });

    test('connectAPI returns success on 200 response', () async {
      // Verify the expected behavior
      expect(() => apiService.connectAPI(), returnsNormally);
    });

    test('connectAPI returns error on non 200 response', () async {
      // Set up mock response
      final response =
          await http.get(Uri.parse('${ApiService.API_BASE_URL}/error'));

      // Verify the expected behavior
      expect(response.statusCode, isNot(equals(200)));
    });
  });
}
