import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/presentation/pages/users_screen.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/presentation/styles/theme.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: const Icon(CupertinoIcons.chat_bubble),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UsersScreen())),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const EventTile();
        },
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  const EventTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Logger.debug('TODO event tile'),
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: .2,
            ),
          ),
        ),
      ),
    );
  }
}
