import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/services/api_service_interface.dart';
import '../../../domain/services/code_service_interface.dart';
import '../../../domain/services/email_service_interface.dart';
import '../../../domain/services/user_service_interface.dart';
import '../../../infrastructure/services/api_service.dart';
import '../../../infrastructure/services/code_service.dart';
import '../../../infrastructure/services/email_service.dart';
import '../../../infrastructure/services/user_service.dart';

@immutable
abstract class Dependencies {
  static void injectDependencies() {
    GetIt.instance.registerLazySingleton<IApiService>(() => ApiService());
    GetIt.instance.registerLazySingleton<IEmailService>(() => EmailService());
    GetIt.instance.registerLazySingleton<IUserService>(() => UserService());
    GetIt.instance.registerLazySingleton<ICodeService>(() => CodeService());
  }
}
