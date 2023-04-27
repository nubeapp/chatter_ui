import 'package:flutter/material.dart';

@immutable
class Token {
  final String accessToken;
  final String type;

  const Token({
    required this.accessToken,
    this.type = 'bearer',
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['accessToken'],
      type: json['type'] ?? 'bearer',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['type'] = type;
    return data;
  }
}
