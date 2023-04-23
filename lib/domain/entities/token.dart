import 'package:flutter/material.dart';

@immutable
class Token {
  final String token;
  final String type;

  const Token({
    required this.token,
    this.type = 'bearer',
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token: json['accessToken'],
      type: json['type'] ?? 'bearer',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = token;
    data['type'] = type;
    return data;
  }
}
