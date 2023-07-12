import 'package:flutter/material.dart';

@immutable
abstract class IFavouriteService {
  Future<void> addToFavourites(int eventId);
  Future<void> deleteFromFavourites(int eventId);
}
