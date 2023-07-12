import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/domain/services/api_service_interface.dart';
import 'package:ui/domain/services/auth_service_interface.dart';
import 'package:ui/domain/services/code_service_interface.dart';
import 'package:ui/domain/services/email_service_interface.dart';
import 'package:ui/domain/services/event_service_interface.dart';
import 'package:ui/domain/services/favourite_service_interface.dart';
import 'package:ui/domain/services/ticket_service_interface.dart';
import 'package:ui/domain/services/user_service_interface.dart';
import 'package:ui/infrastructure/http/http_client.dart';
import 'package:ui/infrastructure/services/api_service.dart';
import 'package:ui/infrastructure/services/auth_service.dart';
import 'package:ui/infrastructure/services/code_service.dart';
import 'package:ui/infrastructure/services/email_service.dart';
import 'package:ui/infrastructure/services/event_service.dart';
import 'package:ui/infrastructure/services/favourite_service.dart';
import 'package:ui/infrastructure/services/ticket_service.dart';
import 'package:ui/infrastructure/services/user_service.dart';
import 'package:http/http.dart' as http;

@immutable
abstract class Dependencies {
  static void injectDependencies() async {
    GetIt.instance.registerLazySingleton<http.Client>(() => HttpClientFactory.create());

    GetIt.instance.registerLazySingleton<IApiService>(
      () => ApiService(client: GetIt.instance<http.Client>()),
    );
    GetIt.instance.registerLazySingleton<IEmailService>(
      () => EmailService(client: GetIt.instance<http.Client>()),
    );
    GetIt.instance.registerLazySingleton<IUserService>(
      () => UserService(client: GetIt.instance<http.Client>()),
    );
    GetIt.instance.registerLazySingleton<ICodeService>(
      () => CodeService(client: GetIt.instance<http.Client>()),
    );
    GetIt.instance.registerLazySingleton<IEventService>(
      () => EventService(client: GetIt.instance<http.Client>()),
    );
    GetIt.instance.registerLazySingleton<IAuthService>(
      () => AuthService(client: GetIt.instance<http.Client>()),
    );
    GetIt.instance.registerLazySingleton<ITicketService>(
      () => TicketService(client: GetIt.instance<http.Client>()),
    );
    GetIt.instance.registerLazySingleton<IFavouriteService>(
      () => FavouriteService(client: GetIt.instance<http.Client>()),
    );
  }
}
