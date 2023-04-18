import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';

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
                  Text(
                      'Owner: ${widget.event.owner!.name} ${widget.event.owner!.surname}')
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
                        ownerId: widget.event.ownerId,
                        title: widget.event.title,
                        completed: !widget.event.completed,
                      ));
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
