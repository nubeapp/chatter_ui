import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/application/services/dependency_injection/dependencies.dart';
import 'package:ui/presentation/bloc/ticket_counter/ticket_counter_bloc.dart';
import 'presentation/pages/pages.dart';

void main() {
  Dependencies.injectDependencies();
  runApp(
    const MyApp(
        // appTheme: AppTheme(),
        ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    // required this.appTheme,
  }) : super(key: key);

  // final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TicketCounterBloc>(
          create: (context) => TicketCounterBloc(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: appTheme.light,
        // darkTheme: appTheme.dark,
        // themeMode: ThemeMode.dark,
        title: 'Ticketo',
        home: MainScreen(),
      ),
    );
  }
}
