import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/domain/entities/token.dart';
import 'package:ui/infrastructure/utilities/auth_endpoints.dart';

class TokenInterceptor extends http.BaseClient {
  final http.Client client;

  TokenInterceptor({required this.client});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey('token')) {
      final String? strToken = sharedPreferences.getString('token');
      Token token = Token.fromJson(json.decode(strToken ?? ''));
      if (_requiresTokenAuthentication(request.url.toString())) {
        request.headers['Authorization'] = 'Bearer ${token.accessToken}';
      }
    }
    return client.send(request);
  }

  bool _requiresTokenAuthentication(String url) {
    return AuthEndpoints.enpoints.any((endpoint) => url.contains(endpoint));
  }
}
