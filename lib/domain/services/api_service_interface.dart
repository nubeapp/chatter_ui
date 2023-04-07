import 'package:flutter/material.dart';

@immutable
abstract class IApiService {
  Future<void> connectAPI();
}
