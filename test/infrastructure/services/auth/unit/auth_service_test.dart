import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/domain/entities/token.dart';
import 'package:ui/domain/services/auth_service_interface.dart';
import 'package:ui/infrastructure/services/auth_service.dart';

import '../../../mocks/mock_objects.dart';
import '../../../mocks/mock_responses.dart';
import 'auth_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const String API_BASE_URL = 'http://0.0.0.0:8000/login';
  late IAuthService authService;

  group('AuthService', () {
    group('login', () {
      test('returns a token', () async {
        final mockClient = MockClient();
        authService = AuthService(client: mockClient);

        when(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockCredentialsObject.toJson()),
        )).thenAnswer((_) async => http.Response(json.encode(mockTokenResponse), 200));

        final token = await authService.login(mockCredentialsObject);

        expect(token, isA<Token>());
        expect(token.accessToken,
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c');
        expect(token.type, 'bearer');

        verify(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockCredentialsObject.toJson()),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        authService = AuthService(client: mockClient);

        when(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockCredentialsObject.toJson()),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(authService.login(mockCredentialsObject), throwsException);

        verify(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(mockCredentialsObject.toJson()),
        )).called(1);
      });
    });
  });
}
