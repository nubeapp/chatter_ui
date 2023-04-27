import 'package:flutter/material.dart';
import 'package:ui/domain/entities/credentials.dart';
import 'package:ui/domain/entities/token.dart';

@immutable
abstract class IAuthService {
  Future<Token> login(Credentials credentials);
}
