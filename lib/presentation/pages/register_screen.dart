import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/domain/entities/code.dart';
import 'package:ui/domain/entities/user.dart';
import 'package:ui/domain/services/api_service_interface.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:ui/domain/services/email_service_interface.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/pages/pages.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/presentation/widgets/button.dart';
import 'package:ui/extensions/extensions.dart';
import 'package:ui/presentation/widgets/input_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final apiService = GetIt.instance.get<IApiService>();
  final emailService = GetIt.instance.get<IEmailService>();
  final codeService = GetIt.instance.get<ICodeService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w * 0.075),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.h * 0.1),
              const Text(
                'Introduzca los siguientes datos para registrarse...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  height: 2.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child:
                    InputField(hintText: 'Email', controller: _emailController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child:
                    InputField(hintText: 'Name', controller: _nameController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: InputField(
                    hintText: 'Surname', controller: _surnameController),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: InputField(
                    hintText: 'Password', controller: _passwordController),
              ),
              SizedBox(height: context.h * 0.05),
              Center(
                child: Button(
                  text: 'Continuar',
                  onPressed: () async {
                    // 1. Check if every field has data
                    if (_emailController.text.isNotEmpty &&
                        _nameController.text.isNotEmpty &&
                        _surnameController.text.isNotEmpty &&
                        _passwordController.text.isNotEmpty) {
                      // 2. Generate random code of 5 digits
                      String randomCode = Helpers.randomCode();
                      // 3. Store code in database
                      Code code =
                          Code(email: _emailController.text, code: randomCode);
                      await compute(codeService.createCode, code);
                      // 4. Form the User to register it later
                      User user = User(
                        email: _emailController.text,
                        name: _nameController.text,
                        surname: _surnameController.text,
                        password: _passwordController.text,
                      );
                      // 4. Navigate to next screen
                      Logger.warning('Switching to next screen...');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerificationScreen(
                              user: user,
                            ),
                          ));
                      // 6. Send the code through email
                      await emailService.sendCode(
                        _emailController.text,
                        _nameController.text,
                        randomCode,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
