import 'package:flutter_test/flutter_test.dart';
import 'package:ui/domain/entities/code.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:ui/infrastructure/services/code_service.dart';

void main() {
  late ICodeService codeService;
  const Code johnCode = Code(email: 'johndoe@example.com', code: '12345');
  const Code janeCode = Code(email: 'janedoe@example.com', code: '67890');
  const Code updatedCode = Code(email: 'johndoe@example.com', code: '54321');

  setUp(() async {
    codeService = CodeService();
    await codeService.createCode(johnCode);
  });

  tearDown(() async {
    codeService.deleteCodeByEmail('johndoe@example.com');
  });

  group('CodeService', () {
    group('getCodes', () {
      test('returns list of codes on success', () async {
        // Act
        final codes = await codeService.getCodes();

        // Assert
        expect(codes.length, equals(1));
        expect(codes.first.email, 'johndoe@example.com');
        expect(codes.first.code, '12345');
      });
    });

    group('getCodeByEmail', () {
      test('returns code on success', () async {
        // Act
        final code = await codeService.getCodeByEmail('johndoe@example.com');

        // Assert
        expect(code.email, 'johndoe@example.com');
        expect(code.code, '12345');
      });

      test('throws exception on failure', () async {
        expect(() => codeService.getCodeByEmail('janedoe@example.com'),
            throwsException);
      });
    });

    group('createCode', () {
      test('creates a new code and adds it to the list', () async {
        // Act
        final initialCodes = await codeService.getCodes();
        await codeService.createCode(janeCode);
        final updatedCodes = await codeService.getCodes();

        // Assert
        expect(updatedCodes.length, initialCodes.length + 1);
        expect(updatedCodes.last.email, 'janedoe@example.com');
        expect(updatedCodes.last.code, '67890');
      });

      test('throws exception on failure', () async {
        expect(() => codeService.createCode(johnCode), throwsException);
      });
    });

    group('updateCode', () {
      test('update code on success', () async {
        // Act
        final code = await codeService.updateCodeByEmail(
            'johndoe@example.com', updatedCode);
        final johnAfterUpdate =
            await codeService.getCodeByEmail('johndoe@example.com');

        // Assert
        expect(code.code, johnAfterUpdate.code);
      });

      test('throws exception on failure', () async {
        expect(
            () => codeService.updateCodeByEmail(
                'janedoe@example.com', updatedCode),
            throwsException);
      });
    });

    group('deleteCodeByEmail', () {
      test('delete code on success', () async {
        // Act
        await codeService.deleteCodeByEmail('johndoe@example.com');

        // Assert
        expect(() => codeService.getCodeByEmail('johndoe@example.com'),
            throwsException);
      });

      test('throws exception on failure', () async {
        expect(() => codeService.deleteCodeByEmail('janedoe@example.com'),
            throwsException);
      });
    });
  });
}
