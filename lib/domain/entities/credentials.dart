import 'package:flutter/material.dart';

@immutable
class Credentials {
  final String email;
  final String password;

  const Credentials({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = email;
    data['password'] = password;
    return data;
  }
}
