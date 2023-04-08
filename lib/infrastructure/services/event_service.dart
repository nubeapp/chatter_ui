import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/presentation/styles/logger.dart';

class EventService implements IEventService {
  static String get API_BASE_URL => 'http://localhost:8000/events';

  @override
  Future<List<Event>> getEvents() async {
    Logger.debug('Requesting all events to database...');
    final response = await http.get(Uri.parse(API_BASE_URL));
    if (response.statusCode == 200) {
      Logger.info('Events have been retrieved successfully!');
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Event.fromJson(e)).toList();
    } else {
      Logger.error('Failed to get events');
      throw Exception(
          'Failed to get events. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<Event> getEventById(int eventId) async {
    Logger.debug('Requesting event with id $eventId...');
    final response = await http.get(Uri.parse('$API_BASE_URL/event/$eventId'));
    if (response.statusCode == 200) {
      Logger.info('Event with id $eventId was retrieved successfully!');
      final Map<String, dynamic> data = json.decode(response.body);
      return Event.fromJson(data);
    } else {
      Logger.error('Failed to get event with id $eventId');
      throw Exception(
          'Failed to get event by id. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<List<Event>> getEventsByOwnerId(int ownerId) async {
    Logger.debug('Requesting events by owner_id $ownerId...');
    final response = await http.get(Uri.parse('$API_BASE_URL/$ownerId'));
    if (response.statusCode == 200) {
      Logger.info(
          'Events of owner_id $ownerId have been retrieved succesfully!');
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Event.fromJson(e)).toList();
    } else {
      Logger.error('Failed to get events by owner_id $ownerId');
      throw Exception(
          'Failed to get events by owner id. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<Event> createEvent(Event event) async {
    Logger.debug('Creating new event ${event.title}...');
    final response = await http.post(Uri.parse(API_BASE_URL),
        body: json.encode(event.toJson()));
    if (response.statusCode == 201) {
      Logger.info('The event ${event.title} was created successfully!');
      final Map<String, dynamic> data = json.decode(response.body);
      return Event.fromJson(data);
    } else {
      Logger.error('Failed to create the event');
      throw Exception(
          'Failed to create event. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<Event> updateEventById(int eventId, Event updatedEvent) async {
    Logger.debug('Updating the event with id $eventId...');
    final response = await http.put(Uri.parse('$API_BASE_URL/$eventId'),
        body: json.encode(updatedEvent.toJson()));
    if (response.statusCode == 200) {
      Logger.info('The event with id $eventId has been updated succesfully!');
      final Map<String, dynamic> data = json.decode(response.body);
      return Event.fromJson(data);
    } else {
      Logger.error('Failed to update event with id $eventId');
      throw Exception(
          'Failed to update event by id. Status code: ${response.statusCode}');
    }
  }

  @override
  Future<void> deleteEventById(int eventId) async {
    Logger.debug('Deleting event with id $eventId...');
    final response =
        await http.delete(Uri.parse('$API_BASE_URL/event/$eventId'));
    if (response.statusCode != 204) {
      Logger.error('Failed to delete event with id $eventId');
      throw Exception(
          'Failed to delete event by id. Status code: ${response.statusCode}');
    }
    Logger.info('Event with id $eventId has been deleted successfully!');
  }

  @override
  Future<void> deleteEventsByOwnerId(int ownerId) async {
    Logger.debug('Deleting events by owner_id $ownerId...');
    final response = await http.delete(Uri.parse('$API_BASE_URL/$ownerId'));
    if (response.statusCode != 204) {
      Logger.error('Failed to delete events by owner_id $ownerId');
      throw Exception(
          'Failed to delete events by owner id. Status code: ${response.statusCode}');
    }
    Logger.info('Events by owner_id $ownerId have been deleted successfully!');
  }

  @override
  Future<void> deleteAllEvents() async {
    Logger.debug('Deleting all the events in the database...');
    final response = await http.delete(Uri.parse(API_BASE_URL));
    if (response.statusCode != 204) {
      Logger.error('Failed to delete all events');
      throw Exception(
          'Failed to delete all events. Status code: ${response.statusCode}');
    }
    Logger.info('All the events have been deleted successfully!');
  }
}
