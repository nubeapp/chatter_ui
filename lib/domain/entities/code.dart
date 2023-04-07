import 'package:flutter/material.dart';

@immutable
class Code {
  final String email;
  final String code;

  const Code({required this.email, required this.code});

  factory Code.fromJson(Map<String, dynamic> json) {
    return Code(
      email: json['email'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}
