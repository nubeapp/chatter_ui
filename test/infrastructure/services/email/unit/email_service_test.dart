import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/domain/entities/email_data.dart';
import 'package:ui/domain/services/email_service_interface.dart';
import 'package:ui/infrastructure/services/email_service.dart';

import '../../../mocks/mock_objects.dart';
import 'email_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('EmailService', () {
    const String API_BASE_URL = 'http://0.0.0.0:8000/email/send';
    late IEmailService emailService;

    test('sendCode send code through email without exception', () async {
      final mockClient = MockClient();
      emailService = EmailService(client: mockClient);

      when(mockClient.post(
        Uri.parse(API_BASE_URL),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(mockEmailDataObject.toJson()),
      )).thenAnswer((_) async => http.Response('', 200));

      await emailService.sendCode(mockEmailDataObject);

      verify(mockClient.post(
        Uri.parse(API_BASE_URL),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(mockEmailDataObject.toJson()),
      )).called(1);
      // Act & Assert
      // expect(() => emailService.sendCode(email, name, code), returnsNormally);
    });

    test('throws an exception if the http call completes with an error', () {
      final mockClient = MockClient();
      emailService = EmailService(client: mockClient);

      when(mockClient.post(
        Uri.parse(API_BASE_URL),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(mockEmailDataObject.toJson()),
      )).thenAnswer((_) async => http.Response('Error sending email', 404));

      expect(emailService.sendCode(mockEmailDataObject), throwsException);

      verify(mockClient.post(
        Uri.parse(API_BASE_URL),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(mockEmailDataObject.toJson()),
      )).called(1);
    });

    // test('sendCode() returns success with status code 200', () async {
    //   // Act
    //   final response = await http.post(
    //     Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: json.encode(emailData.toJson()),
    //   );
    //   // Assert
    //   expect(response.statusCode, 200);
    // });

    // test('sendCode() returns success data in body', () async {
    //   // Act
    //   final response = await http.post(
    //     Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'},
    //     body: json.encode(emailData.toJson()),
    //   );
    //   final responseBody = jsonDecode(response.body) as Map<String, dynamic>;
    //   // Assert
    //   expect(responseBody, equals({'message': 'Email sent successfully'}));
    // });
  });
}
