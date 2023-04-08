import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/presentation/pages/users_screen.dart';
import 'package:ui/presentation/styles/logger.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _eventService = GetIt.instance.get<IEventService>();
  Future<List<Event>>? _events;

  @override
  void initState() {
    super.initState();
    _events = _eventService.getEvents();
  }

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
      body: FutureBuilder<List<Event>>(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isNotEmpty) {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final Event event = users[index];
                  return EventTile(event: event);
                },
              );
            } else if (snapshot.hasError) {
              Logger.error('Error loading events: ${snapshot.error}');
              return Center(
                child: Text('Error loading events: ${snapshot.error}'),
              );
            } else {
              Logger.warning('No events found');
              return const Center(
                child: Text(
                  'No events found',
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class EventTile extends StatefulWidget {
  const EventTile({super.key, required this.event});

  final Event event;

  @override
  State<EventTile> createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  final _eventService = GetIt.instance.get<IEventService>();
  late bool _completed;

  @override
  void initState() {
    super.initState();
    _completed = widget.event.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Ink(
        height: 90,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('Owner: ${widget.event.ownerId}')
                ],
              ),
              GestureDetector(
                onTap: () async {
                  setState(() {
                    _completed = !_completed;
                  });
                  await _eventService.updateEventById(
                      widget.event.id!,
                      Event(
                          ownerId: 30,
                          title: widget.event.title,
                          completed: !widget.event.completed));
                },
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: _completed ? Colors.green : Colors.red,
                    ),
                  ),
                  child: _completed
                      ? const Icon(CupertinoIcons.checkmark_alt,
                          color: Colors.green)
                      : const Icon(CupertinoIcons.clear_thick,
                          color: Colors.red),
                ),
                // child: Text('$_completed'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
