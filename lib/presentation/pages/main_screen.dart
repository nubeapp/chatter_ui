import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/presentation/pages/users_screen.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/presentation/widgets/event_tile.dart';
import 'package:ui/presentation/widgets/input_field.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            icon: const Icon(CupertinoIcons.chat_bubble),
            onPressed: () {},
            // onPressed: () => Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const UsersScreen())),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).bottomAppBarColor,
      //   onPressed: () => _showDialog(context),
      //   child: const Icon(
      //     CupertinoIcons.add,
      //     color: Colors.white,
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: ListView.separated(
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(
            height: 20,
          ),
          itemBuilder: (context, index) => const Center(
            child: EventTile(),
          ),
        ),
      ),
      // body: FutureBuilder<List<Event>>(
      //   // future: _events,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       if (snapshot.data!.isNotEmpty) {
      //         final users = snapshot.data!;
      //         return ListView.builder(
      //           itemCount: users.length,
      //           itemBuilder: (context, index) {
      //             final Event event = users[index];
      //             return EventTile(event: event);
      //           },
      //         );
      //       } else if (snapshot.hasError) {
      //         Logger.error('Error loading events: ${snapshot.error}');
      //         return Center(
      //           child: Text('Error loading events: ${snapshot.error}'),
      //         );
      //       } else {
      //         Logger.warning('No events found');
      //         return const Center(
      //           child: Text(
      //             'No events found',
      //           ),
      //         );
      //       }
      //     } else {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }

  TextEditingController titleController = TextEditingController();

  void _showDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New event...'),
          content: InputField(
            hintText: 'Event title',
            controller: titleController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
