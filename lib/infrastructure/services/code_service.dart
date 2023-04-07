import 'dart:convert';

import 'package:ui/domain/entities/code.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:http/http.dart' as http;
import 'package:ui/presentation/styles/logger.dart';

class CodeService implements ICodeService {
  static String get API_BASE_URL => 'http://0.0.0.0:8000/codes';

  @override
  Future<List<Code>> getCodes() async {
    Logger.debug('Requesting all codes to database...');
    final response = await http.get(Uri.parse(API_BASE_URL));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      final List<Code> codes =
          responseData.map((json) => Code.fromJson(json)).toList();
      Logger.info('Codes have been received!');
      return codes;
    } else {
      Logger.error('Failed to load codes');
      throw Exception('Failed to load codes');
    }
  }

  @override
  Future<Code> getCodeByEmail(String email) async {
    Logger.debug('Requesting the code $email to database...');
    final response = await http.get(Uri.parse('$API_BASE_URL/$email'));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final Code code = Code.fromJson(responseData);
      Logger.info('Code ${code.code} has been retrieved successfully!');
      return code;
    } else if (response.statusCode == 404) {
      Logger.error('The email $email has not code associated');
      throw Exception('The email $email has not code associated');
    } else {
      Logger.error(
          'Failed to get code for email $email: ${response.statusCode}');
      throw Exception(
          'Failed to get code for email $email: ${response.statusCode}');
    }
  }

  @override
  Future<Code> createCode(Code code) async {
    Logger.debug('Creating code {"${code.email}": "${code.code}"}...');
    final response = await http.post(Uri.parse(API_BASE_URL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(code.toJson()));
    if (response.statusCode == 201) {
      Logger.info('Code has been stored successfully!');
      return Code.fromJson(jsonDecode(response.body));
    } else {
      Logger.error('Failed to create the code: ${response.statusCode}');
      throw Exception('Failed to create code: ${response.statusCode}');
    }
  }

  @override
  Future<Code> updateCodeByEmail(String email, Code updatedCode) async {
    Logger.debug(
        'Replacing the code associated to email $email by ${updatedCode.code}...');
    final response = await http.put(Uri.parse('$API_BASE_URL/$email'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedCode.toJson()));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final Code code = Code.fromJson(responseData);
      Logger.info(
          'The code associated to email $email has been updated successfully to ${code.code}!');
      return code;
    } else if (response.statusCode == 404) {
      Logger.error('The email $email has not code associated');
      throw Exception('The email $email has not code associated');
    } else {
      Logger.error(
          'Failed to update code for email $email: ${response.statusCode}');
      throw Exception(
          'Failed to update code for email $email: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteCodeByEmail(String email) async {
    Logger.debug('Deleting the code associated to email $email...');
    final response = await http.delete(Uri.parse('$API_BASE_URL/$email'));
    if (response.statusCode == 204) {
      Logger.info(
          'The code associated to email $email has been deleted successfully!');
    } else if (response.statusCode == 404) {
      Logger.error('The email $email has not code associated');
      throw Exception('The email $email has not code associated');
    } else {
      Logger.error(
          'Failed to delete code for email $email: ${response.statusCode}');
      throw Exception(
          'Failed to delete code for email $email: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteCodes() async {
    Logger.debug('Deleting all the codes in the database...');
    final response = await http.delete(Uri.parse(API_BASE_URL));
    if (response.statusCode != 204) {
      Logger.error('Failed to delete codes');
      throw Exception('Failed to delete codes');
    }
    Logger.info('All the codes have been deleted successfully!');
  }
}
