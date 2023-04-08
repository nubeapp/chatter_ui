import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/domain/entities/user.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:ui/domain/services/user_service_interface.dart';
import 'package:ui/presentation/pages/users_screen.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/presentation/widgets/button.dart';
import 'package:ui/extensions/extensions.dart';

import '../widgets/input_field.dart';

class VerificationScreen extends StatelessWidget {
  VerificationScreen({super.key, required this.user});

  final User user;
  final TextEditingController _codeController = TextEditingController();
  final codeService = GetIt.instance.get<ICodeService>();
  final userService = GetIt.instance.get<IUserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w * 0.075),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.h * 0.05),
              const Text(
                'Introduzca el código que has recibido para finalizar el registro',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                  height: 2.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child:
                    InputField(hintText: 'Code', controller: _codeController),
              ),
              SizedBox(height: context.h * 0.025),
              Center(
                child: Button(
                  text: 'Finalizar',
                  onPressed: () async {
                    // 2. Check if the code is the same stored in database

                    final databaseCode =
                        await compute(codeService.getCodeByEmail, user.email);
                    if (databaseCode.code.equals(_codeController.text)) {
                      // 5. Navigate to main screen
                      Logger.warning('Switching to next screen...');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UsersScreen()));
                      // 3. Create the user in the database
                      await compute(userService.createUser, user);
                      // 4. Delete the stored code
                      await compute(codeService.deleteCodeByEmail, user.email);
                    } else {
                      Logger.warning(
                          'The code does not match with the one sent by email to ${user.email}');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
