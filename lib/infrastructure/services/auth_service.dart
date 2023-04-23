import 'package:ui/domain/entities/token.dart';
import 'package:ui/domain/services/auth_service_interface.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService implements IAuthService {
  AuthService();
  static String get API_BASE_URL => 'http://0.0.0.0:8000/';
  @override
  Future<Token> login(String email, String password) async {
    final url = Uri.parse('http://0.0.0.0:8000/login');
    final response = await http.post(
      url,
      body: {'username': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Token.fromJson(json);
    } else {
      throw Exception('Failed to login');
    }
  }
}
