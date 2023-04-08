import 'package:ui/domain/entities/event.dart';

abstract class IEventService {
  Future<List<Event>> getEvents();

  Future<Event> getEventById(int eventId);

  Future<List<Event>> getEventsByOwnerId(int ownerId);

  Future<Event> createEvent(Event event);

  Future<Event> updateEventById(int eventId, Event updatedEvent);

  Future<void> deleteEventById(int eventId);

  Future<void> deleteEventsByOwnerId(int ownerId);

  Future<void> deleteAllEvents();
}
