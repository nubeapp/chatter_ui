import 'dart:convert';

import 'package:ui/domain/entities/code.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:http/http.dart' as http;
import 'package:ui/presentation/styles/logger.dart';

class CodeService implements ICodeService {
  CodeService({required this.client});

  static String get API_BASE_URL => 'http://0.0.0.0:8000/codes';
  final http.Client client;

  @override
  Future<List<Code>> getCodes() async {
    try {
      Logger.debug('Requesting all codes from the database...');
      final response = await client.get(Uri.parse(API_BASE_URL));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
        final List<Code> codes = responseData.map((json) => Code.fromJson(json)).toList();
        Logger.info('Codes have been received!');
        return codes;
      } else {
        Logger.error('Failed to load codes');
        throw Exception('Failed to load codes');
      }
    } catch (e) {
      Logger.error('An error occurred while getting codes: $e');
      throw Exception('Failed to load codes');
    }
  }

  @override
  Future<Code> getCodeByEmail(String email) async {
    try {
      Logger.debug('Requesting the code $email from the database...');
      final response = await client.get(Uri.parse('$API_BASE_URL/$email'));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final Code code = Code.fromJson(responseData);
        Logger.info('Code ${code.code} has been retrieved successfully!');
        return code;
      } else if (response.statusCode == 404) {
        Logger.error('The email $email has no associated code');
        throw Exception('The email $email has no associated code');
      } else {
        Logger.error('Failed to get code for email $email: ${response.statusCode}');
        throw Exception('Failed to get code for email $email: ${response.statusCode}');
      }
    } catch (e) {
      Logger.error('An error occurred while getting the code for email $email: $e');
      throw Exception('Failed to get code for email $email');
    }
  }

  @override
  Future<Code> createCode(Code code) async {
    try {
      Logger.debug('Creating code {"${code.email}": "${code.code}"}...');
      final response = await client.post(
        Uri.parse(API_BASE_URL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(code.toJson()),
      );

      if (response.statusCode == 201) {
        Logger.info('Code has been stored successfully!');
        return Code.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      } else {
        Logger.error('Failed to create the code: ${response.statusCode}');
        throw Exception('Failed to create code: ${response.statusCode}');
      }
    } catch (e) {
      Logger.error('An error occurred while creating the code: $e');
      throw Exception('Failed to create code');
    }
  }

  @override
  Future<Code> updateCodeByEmail(String email, Code updatedCode) async {
    try {
      Logger.debug('Replacing the code associated with email $email by ${updatedCode.code}...');
      final response = await client.put(
        Uri.parse('$API_BASE_URL/$email'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(updatedCode.toJson()),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes));
        final Code code = Code.fromJson(responseData);
        Logger.info('The code associated with email $email has been updated successfully to ${code.code}!');
        return code;
      } else if (response.statusCode == 404) {
        Logger.error('The email $email has no associated code');
        throw Exception('The email $email has no associated code');
      } else {
        Logger.error('Failed to update code for email $email: ${response.statusCode}');
        throw Exception('Failed to update code for email $email: ${response.statusCode}');
      }
    } catch (e) {
      Logger.error('An error occurred while updating the code for email $email: $e');
      throw Exception('Failed to update code for email $email');
    }
  }

  @override
  Future<void> deleteCodeByEmail(String email) async {
    try {
      Logger.debug('Deleting the code associated with email $email...');
      final response = await client.delete(Uri.parse('$API_BASE_URL/$email'));

      if (response.statusCode == 204) {
        Logger.info('The code associated with email $email has been deleted successfully!');
      } else if (response.statusCode == 404) {
        Logger.error('The email $email has no associated code');
        throw Exception('The email $email has no associated code');
      } else {
        Logger.error('Failed to delete code for email $email: ${response.statusCode}');
        throw Exception('Failed to delete code for email $email: ${response.statusCode}');
      }
    } catch (e) {
      Logger.error('An error occurred while deleting the code for email $email: $e');
      throw Exception('Failed to delete code for email $email');
    }
  }

  @override
  Future<void> deleteCodes() async {
    try {
      Logger.debug('Deleting all codes in the database...');
      final response = await client.delete(Uri.parse(API_BASE_URL));

      if (response.statusCode != 204) {
        Logger.error('Failed to delete codes');
        throw Exception('Failed to delete codes');
      }

      Logger.info('All codes have been deleted successfully!');
    } catch (e) {
      Logger.error('An error occurred while deleting codes: $e');
      throw Exception('Failed to delete codes');
    }
  }
}
