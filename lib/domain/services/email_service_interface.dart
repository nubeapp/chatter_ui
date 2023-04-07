import 'package:flutter/material.dart';

@immutable
abstract class IEmailService {
  Future<void> sendCode(String email, String name, String code);
}
