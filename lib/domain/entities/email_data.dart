import 'package:flutter/material.dart';

@immutable
class EmailData {
  final String email;
  final String name;
  final String code;

  const EmailData({
    required this.email,
    required this.name,
    required this.code,
  });

  factory EmailData.fromJson(Map<String, dynamic> json) {
    return EmailData(
      email: json['email'],
      name: json['name'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'code': code,
    };
  }
}
