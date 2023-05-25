import 'package:ui/domain/entities/credentials.dart';
import 'package:ui/domain/entities/token.dart';
import 'package:ui/domain/services/auth_service_interface.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/presentation/styles/logger.dart';

class AuthService implements IAuthService {
  AuthService({required this.client});
  static String get API_BASE_URL => 'http://0.0.0.0:8000/login';
  final http.Client client;

  @override
  Future<Token> login(Credentials credentials) async {
    try {
      Logger.debug('Trying to log in user ${credentials.email}...');
      final response = await client.post(
        Uri.parse(API_BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(credentials.toJson()),
      );

      if (response.statusCode == 200) {
        Logger.info('Logged in successfully!');
        final json = jsonDecode(response.body);
        return Token.fromJson(json);
      } else {
        Logger.error('Failed to login');
        throw Exception('Failed to login');
      }
    } catch (e) {
      Logger.error('An error occurred during login: $e');
      throw Exception('Failed to login');
    }
  }
}
