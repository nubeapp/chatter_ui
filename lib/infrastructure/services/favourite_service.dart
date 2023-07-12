import 'package:ui/domain/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:ui/domain/services/favourite_service_interface.dart';
import 'package:ui/presentation/styles/logger.dart';

class FavouriteService implements IFavouriteService {
  FavouriteService({required this.client});

  static String get API_BASE_URL => 'http://0.0.0.0:8000/favourites';
  final http.Client client;

  @override
  Future<void> addToFavourites(int eventId) async {
    try {
      Logger.debug('Adding to favourites event $eventId');
      final response = await client.post(
        Uri.parse('$API_BASE_URL/$eventId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        Logger.info('Event has been added to favourites successfully!');
      } else if (response.statusCode == 404) {
        throw NotFoundException('The event does not exist');
      } else if (response.statusCode == 409) {
        throw DuplicateFavouriteEventException('The user has already added the event to favourites');
      } else {
        throw Exception('Failed to adding event to favourites: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteFromFavourites(int eventId) async {
    try {
      Logger.debug('Deleting event $eventId from favourites...');
      final response = await client.delete(Uri.parse('$API_BASE_URL/$eventId'));

      if (response.statusCode == 201) {
        Logger.info('The event $eventId has been deleted from favourites successfully!');
      } else if (response.statusCode == 404) {
        throw NotFoundException('The event does not exist');
      } else if (response.statusCode == 409) {
        throw NotFoundException('The user has not the event as favourite');
      } else {
        throw Exception('Failed to delete event $eventId from favourites with status: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
