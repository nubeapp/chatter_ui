import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/presentation/pages/users_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.chat_bubble),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UsersScreen())),
          ),
        ],
      ),
    );
  }
}
