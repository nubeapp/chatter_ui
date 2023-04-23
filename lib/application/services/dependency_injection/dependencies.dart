import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/domain/services/api_service_interface.dart';
import 'package:ui/domain/services/auth_service_interface.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:ui/domain/services/email_service_interface.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/domain/services/user_service_interface.dart';
import 'package:ui/infrastructure/services/api_service.dart';
import 'package:ui/infrastructure/services/auth_service.dart';
import 'package:ui/infrastructure/services/code_service.dart';
import 'package:ui/infrastructure/services/email_service.dart';
import 'package:ui/infrastructure/services/event_service.dart';
import 'package:ui/infrastructure/services/user_service.dart';
import 'package:http/http.dart' as http;

@immutable
abstract class Dependencies {
  static void injectDependencies() {
    GetIt.instance.registerLazySingleton<http.Client>(() => http.Client());
    GetIt.instance.registerLazySingleton<IApiService>(
        () => ApiService(client: GetIt.instance<http.Client>()));
    GetIt.instance.registerLazySingleton<IEmailService>(
        () => EmailService(client: GetIt.instance<http.Client>()));
    GetIt.instance.registerLazySingleton<IUserService>(
        () => UserService(client: GetIt.instance<http.Client>()));
    GetIt.instance.registerLazySingleton<ICodeService>(() => CodeService());
    GetIt.instance.registerLazySingleton<IEventService>(() => EventService());
    GetIt.instance.registerLazySingleton<IAuthService>(() => AuthService());
  }
}
