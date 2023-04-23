import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/domain/entities/email_data.dart';
import 'package:ui/domain/services/email_service_interface.dart';
import 'package:ui/presentation/styles/logger.dart';

class EmailService implements IEmailService {
  EmailService({required this.client});

  final http.Client client;

  static String get API_BASE_URL => 'http://0.0.0.0:8000/email';

  @override
  Future<void> sendCode(String email, String name, String code) async {
    Logger.debug('Sending email...');
    final emailData = EmailData(email: email, name: name, code: code);
    try {
      final response = await client.post(
        Uri.parse('$API_BASE_URL/send'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(emailData.toJson()),
      );
      if (response.statusCode != 200) {
        Logger.error('Failed to send email: ${response.statusCode}');
        throw Exception('Failed to send email: ${response.statusCode}');
      }
      Logger.info('Email has been sent successfully!');
    } catch (error) {
      Logger.error('Error sending email: $error');
    }
  }
}
