import 'package:flutter/material.dart';
import 'package:ui/domain/entities/token.dart';

@immutable
abstract class IAuthService {
  Future<Token> login(String email, String password);
}
