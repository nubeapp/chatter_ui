import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/domain/entities/code.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:ui/infrastructure/services/code_service.dart';
import 'package:http/http.dart' as http;

import '../../../mocks/mock_objects.dart';
import '../../../mocks/mock_responses.dart';
import 'code_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const String API_BASE_URL = 'http://0.0.0.0:8000/codes';
  late ICodeService codeService;

  group('CodeService', () {
    group('getCodes', () {
      test('getCodes returns a list of codes', () async {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);

        when(mockClient.get(Uri.parse(API_BASE_URL))).thenAnswer(
            (_) async => http.Response(json.encode(mockCodeListResponse), 200));

        // Act
        final codes = await codeService.getCodes();

        // Assert
        expect(codes, isA<List<Code>>());
        expect(codes.length, equals(2));
        expect(codes[0].email, 'johndoe@example.com');
        expect(codes[0].code, '12345');
        expect(codes[1].email, 'janesmith@example.com');
        expect(codes[1].code, '67890');

        verify(mockClient.get(Uri.parse(API_BASE_URL))).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);

        when(mockClient.get(Uri.parse(API_BASE_URL)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Act
        expect(codeService.getCodes(), throwsException);

        verify(mockClient.get(Uri.parse(API_BASE_URL))).called(1);
      });
    });

    group('getCodeByEmail', () {
      test('getCodeByEmail returns a code', () async {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        when(mockClient.get(Uri.parse('$API_BASE_URL/$mockEmail'))).thenAnswer(
            (_) async => http.Response(json.encode(mockCodeResponse), 200));

        final code = await codeService.getCodeByEmail(mockEmail);

        expect(code, isA<Code>());
        expect(code.email, 'johndoe@example.com');
        expect(code.code, '12345');

        verify(mockClient.get(Uri.parse('$API_BASE_URL/$mockEmail'))).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        when(mockClient.get(Uri.parse('$API_BASE_URL/$mockEmail')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Act
        expect(codeService.getCodeByEmail(mockEmail), throwsException);

        verify(mockClient.get(Uri.parse('$API_BASE_URL/$mockEmail'))).called(1);
      });
    });

    group('createCode', () {
      test('createCode creates a new code', () async {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);

        when(mockClient.post((Uri.parse(API_BASE_URL)),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(mockCodeObject.toJson())))
            .thenAnswer(
                (_) async => http.Response(json.encode(mockCodeResponse), 201));

        final code = await codeService.createCode(mockCodeObject);

        expect(code, isA<Code>());
        expect(code.email, 'johndoe@example.com');
        expect(code.code, '12345');

        verify(mockClient.post((Uri.parse(API_BASE_URL)),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(mockCodeObject.toJson())))
            .called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);

        when(mockClient.post((Uri.parse(API_BASE_URL)),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(mockCodeObject.toJson())))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Act
        expect(codeService.createCode(mockCodeObject), throwsException);

        verify(mockClient.post((Uri.parse(API_BASE_URL)),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(mockCodeObject.toJson())))
            .called(1);
      });
    });

    group('updateCode', () {
      test('updateCodeByEmail returns a code', () async {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockCodeObject.toJson()),
        )).thenAnswer(
            (_) async => http.Response(json.encode(mockCodeResponse), 200));

        final code =
            await codeService.updateCodeByEmail(mockEmail, mockCodeObject);

        expect(code, isA<Code>());
        expect(code.email, 'johndoe@example.com');
        expect(code.code, '12345');

        verify(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockCodeObject.toJson()),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockCodeObject.toJson()),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(codeService.updateCodeByEmail(mockEmail, mockCodeObject),
            throwsException);

        verify(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockCodeObject.toJson()),
        )).called(1);
      });
    });

    group('deleteCodeByEmail', () {
      test('deleteCodeByEmail is called once', () async {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEmail'),
        )).thenAnswer((_) async => http.Response('[]', 204));

        await codeService.deleteCodeByEmail(mockEmail);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEmail'),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEmail'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(codeService.deleteCodeByEmail(mockEmail), throwsException);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEmail'),
        )).called(1);
      });
    });
  });
}
