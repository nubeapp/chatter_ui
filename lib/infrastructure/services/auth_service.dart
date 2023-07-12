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
      Logger.debug('Trying to log in as ${credentials.username}...');
      final response = await client.post(
        Uri.parse(API_BASE_URL),
        body: {
          'username': credentials.username,
          'password': credentials.password,
        },
      );

      if (response.statusCode == 200) {
        Logger.info('Logged in successfully!');
        return Token.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to login with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
