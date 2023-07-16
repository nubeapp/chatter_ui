import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui/domain/entities/credentials.dart';
import 'package:ui/domain/entities/token.dart';
import 'package:ui/domain/services/auth_service_interface.dart';
import 'package:ui/extensions/extensions.dart';
import 'package:ui/presentation/pages/pages.dart';
import 'package:ui/presentation/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _authService = GetIt.instance<IAuthService>();
  late SharedPreferences _sharedPreferences;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _sharedPreferences = await SharedPreferences.getInstance();
    });
  }

  @override
  Widget build(BuildContext context) {
    BoxDecoration backgroundGradient() => const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF507188),
              Color(0xFFABB7C1),
            ],
          ),
        );
    return Container(
      decoration: backgroundGradient(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.black54)
              : Button.black(
                  text: 'Log in',
                  width: context.w * 0.4,
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    Token token = await _authService.login(const Credentials(username: 'alvarolopsi@gmail.com', password: 'alvarolopsi'));
                    await _sharedPreferences.setString('token', json.encode(token.toJson()));

                    setState(() {
                      _isLoading = false;
                    });

                    Navigator.of(context).push(MaterialPageRoute(
                      settings: const RouteSettings(name: '/home_screen'),
                      builder: (context) => HomeScreen(),
                    ));
                  },
                ),
        ),
      ),
    );
  }
}
