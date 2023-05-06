import 'package:flutter/material.dart';
import 'package:ui/domain/entities/email_data.dart';

@immutable
abstract class IEmailService {
  Future<void> sendCode(EmailData emailData);
}
