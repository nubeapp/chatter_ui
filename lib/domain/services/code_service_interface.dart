import 'package:ui/domain/entities/code.dart';

abstract class ICodeService {
  Future<List<Code>> getCodes();
  Future<Code> getCodeByEmail(String email);
  Future<Code> createCode(Code code);
  Future<Code> updateCodeByEmail(String email, Code updatedCode);
  Future<void> deleteCodeByEmail(String email);
  Future<void> deleteCodes();
}
