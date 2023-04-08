import 'package:flutter_test/flutter_test.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/infrastructure/services/event_service.dart';

void main() {
  late IEventService eventService;

  List<Event> mockedEvents = const [
    Event(ownerId: 30, title: 'Event 1 with owner_id 30'),
    Event(ownerId: 30, title: 'Event 2 with owner_id 30'),
    Event(ownerId: 32, title: 'Event 1 with owner_id 32'),
    Event(ownerId: 1, title: 'Event 1 with owner_id 1'),
  ];

  setUp(() async {
    eventService = EventService();
    mockedEvents.forEach((e) async => await eventService.createEvent(e));
  });

  tearDown(() async {
    eventService.deleteAllEvents();
  });

  group('EventService', () {});
}
