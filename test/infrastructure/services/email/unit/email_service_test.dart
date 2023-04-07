import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:ui/domain/entities/email_data.dart';
import 'package:ui/domain/services/email_service_interface.dart';
import 'package:ui/infrastructure/services/email_service.dart';

void main() {
  group('EmailService', () {
    const String url = 'http://0.0.0.0:8000/email/send';
    late IEmailService emailService;
    const String email = "alvarolopsi@gmail.com";
    const String name = "test";
    const String code = "12345";
    const emailData = EmailData(email: email, name: name, code: code);

    setUp(() {
      emailService = EmailService();
    });

    test('sendCode() executes without throwing an exception', () async {
      // Act & Assert
      expect(() => emailService.sendCode(email, name, code), returnsNormally);
    });

    test('sendCode() returns success with status code 200', () async {
      // Act
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(emailData.toJson()),
      );
      // Assert
      expect(response.statusCode, 200);
    });

    test('sendCode() returns success data in body', () async {
      // Act
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(emailData.toJson()),
      );
      final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
      // Assert
      expect(responseBody, equals({'message': 'Email sent successfully'}));
    });
  });
}
