import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:ui/domain/services/favourite_service_interface.dart';
import 'package:ui/infrastructure/services/favourite_service.dart';

import 'favourite_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late IFavouriteService favouriteService;
  const String API_BASE_URL = 'http://0.0.0.0:8000/favourites';

  group('FavouriteService', () {
    group('addToFavourites', () {
      test('is called once', () async {
        final mockClient = MockClient();
        favouriteService = FavouriteService(client: mockClient);
        const int mockEventId = 1;

        when(mockClient.post(
          Uri.parse('$API_BASE_URL/$mockEventId'),
          headers: {'Content-Type': 'application/json'},
        )).thenAnswer((_) async => http.Response('Succesfully added to favourites', 201));

        await favouriteService.addToFavourites(mockEventId);

        verify(mockClient.post(
          Uri.parse('$API_BASE_URL/$mockEventId'),
          headers: {'Content-Type': 'application/json'},
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        favouriteService = FavouriteService(client: mockClient);
        const int mockEventId = 1;

        when(mockClient.post(
          Uri.parse('$API_BASE_URL/$mockEventId'),
          headers: {'Content-Type': 'application/json'},
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(favouriteService.addToFavourites(mockEventId), throwsException);

        verify(mockClient.post(
          Uri.parse('$API_BASE_URL/$mockEventId'),
          headers: {'Content-Type': 'application/json'},
        )).called(1);
      });
    });

    group('deleteFromFavourites', () {
      test('is called once', () async {
        final mockClient = MockClient();
        favouriteService = FavouriteService(client: mockClient);
        const int mockEventId = 1;

        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEventId'),
        )).thenAnswer((_) async => http.Response('Succesfully deleted from favourites', 201));

        await favouriteService.deleteFromFavourites(mockEventId);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEventId'),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        favouriteService = FavouriteService(client: mockClient);
        const int mockEventId = 1;

        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEventId'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(favouriteService.deleteFromFavourites(mockEventId), throwsException);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEventId'),
        )).called(1);
      });
    });
  });
}
