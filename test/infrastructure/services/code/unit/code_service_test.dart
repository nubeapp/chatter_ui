import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ui/domain/entities/code.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:ui/infrastructure/services/code_service.dart';
import 'package:http/http.dart' as http;

import 'code_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  const String API_BASE_URL = 'http://0.0.0.0:8000/codes';
  late ICodeService codeService;
  // const Code johnCode = Code(email: 'johndoe@example.com', code: '12345');
  // const Code janeCode = Code(email: 'janedoe@example.com', code: '67890');
  // const Code updatedCode = Code(email: 'johndoe@example.com', code: '54321');

  // setUp(() async {
  //   codeService = CodeService();
  //   await codeService.createCode(johnCode);
  // });

  // tearDown(() async {
  //   codeService.deleteCodeByEmail('johndoe@example.com');
  // });

  group('CodeService', () {
    group('getCodes', () {
      test('getCodes returns a list of codes', () async {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);

        when(mockClient.get(Uri.parse(API_BASE_URL))).thenAnswer((_) async =>
            http.Response(
                '[{"email":"johndoe@example.com", "code": "12345"},{"email":"janesmith@example.com", "code":"67890"}]',
                200));

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
            (_) async => http.Response(
                '{"email":"johndoe@example.com", "code": "12345"}', 200));

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

      // test('returns code on success', () async {
      //   // Act
      //   final code = await codeService.getCodeByEmail('johndoe@example.com');

      //   // Assert
      //   expect(code.email, 'johndoe@example.com');
      //   expect(code.code, '12345');
      // });

      // test('throws exception on failure', () async {
      //   expect(() => codeService.getCodeByEmail('janedoe@example.com'),
      //       throwsException);
      // });
    });

    group('createCode', () {
      test('createCode creates a new code', () async {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const mockCode = Code(email: 'johndoe@example.com', code: '12345');

        when(mockClient.post((Uri.parse(API_BASE_URL)),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(mockCode.toJson())))
            .thenAnswer((_) async => http.Response(
                '{"email":"johndoe@example.com", "code":"12345"}', 201));

        final code = await codeService.createCode(mockCode);

        expect(code, isA<Code>());
        expect(code.email, 'johndoe@example.com');
        expect(code.code, '12345');

        verify(mockClient.post((Uri.parse(API_BASE_URL)),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(mockCode.toJson())))
            .called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const mockCode = Code(email: 'johndoe@example.com', code: '12345');

        when(mockClient.post((Uri.parse(API_BASE_URL)),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(mockCode.toJson())))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        // Act
        expect(codeService.createCode(mockCode), throwsException);

        verify(mockClient.post((Uri.parse(API_BASE_URL)),
                headers: {'Content-Type': 'application/json'},
                body: jsonEncode(mockCode.toJson())))
            .called(1);
      });
      // test('creates a new code and adds it to the list', () async {
      //   // Act
      //   final initialCodes = await codeService.getCodes();
      //   await codeService.createCode(janeCode);
      //   final updatedCodes = await codeService.getCodes();

      //   // Assert
      //   expect(updatedCodes.length, initialCodes.length + 1);
      //   expect(updatedCodes.last.email, 'janedoe@example.com');
      //   expect(updatedCodes.last.code, '67890');
      // });

      // test('throws exception on failure', () async {
      //   expect(() => codeService.createCode(johnCode), throwsException);
      // });
    });

    group('updateCode', () {
      test('updateCodeByEmail returns a code', () async {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';
        const mockCode = Code(email: 'johndoe@example.com', code: '12345');

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockCode.toJson()),
        )).thenAnswer((_) async => http.Response(
            '{"email":"johndoe@example.com", "code":"12345"}', 200));

        final code = await codeService.updateCodeByEmail(mockEmail, mockCode);

        expect(code, isA<Code>());
        expect(code.email, 'johndoe@example.com');
        expect(code.code, '12345');

        verify(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockCode.toJson()),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        codeService = CodeService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';
        const mockCode = Code(email: 'johndoe@example.com', code: '12345');

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockCode.toJson()),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(codeService.updateCodeByEmail(mockEmail, mockCode),
            throwsException);

        verify(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockCode.toJson()),
        )).called(1);
      });
      // test('update code on success', () async {
      //   // Act
      //   final code = await codeService.updateCodeByEmail(
      //       'johndoe@example.com', updatedCode);
      //   final johnAfterUpdate =
      //       await codeService.getCodeByEmail('johndoe@example.com');

      //   // Assert
      //   expect(code.code, johnAfterUpdate.code);
      // });

      // test('throws exception on failure', () async {
      //   expect(
      //       () => codeService.updateCodeByEmail(
      //           'janedoe@example.com', updatedCode),
      //       throwsException);
      // });
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
      // test('delete code on success', () async {
      //   // Act
      //   await codeService.deleteCodeByEmail('johndoe@example.com');

      //   // Assert
      //   expect(() => codeService.getCodeByEmail('johndoe@example.com'),
      //       throwsException);
      // });

      // test('throws exception on failure', () async {
      //   expect(() => codeService.deleteCodeByEmail('janedoe@example.com'),
      //       throwsException);
      // });
    });
  });
}
