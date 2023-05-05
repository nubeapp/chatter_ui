import 'package:flutter/material.dart';
import 'package:ui/application/services/dependency_injection/dependencies.dart';
import 'package:ui/presentation/styles/theme.dart';

import 'presentation/pages/pages.dart';

/// TODO:
/// - Test method generateTicketReferencesByEventId()
/// - Fix images of EventTile
/// - Store image of EventTile in database, and how to save it
/// - How to store all the codes generated for each event
/// -

void main() async {
  Dependencies.injectDependencies();
  //final apiService = GetIt.instance.get<IApiService>();
  //await apiService.connectAPI();
  runApp(
    MyApp(
      appTheme: AppTheme(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.appTheme,
  }) : super(key: key);

  final AppTheme appTheme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: ThemeMode.dark,
      title: 'Chatter',
      home: const MainScreen(),
    );
  }
}

/*                       HomeScreen                                                                                  */
/*                                                                                                                   */
/*    |---------------------------------------------|                               MessagesPage                     */
/*    |                    AppBar                   |                                                                */
/*    |---------------------------------------------|              ---------------------------------------------     */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                                             |             | |                  Stories                | |    */
/*    |                                             |             | |  -------   -------   -------   -------  | |    */
/*    |                                             |             | | | Story | | Story | | Story | | Story | | |    */
/*    |                                             |             | | | Card  | | Card  | | Card  | | Card  | | |    */
/*    |                                             |             | |  -------   -------   -------   -------  | |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                                             |             |                                             |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                MessagesPage                 |  -------->  | |                  ChatTile               | |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                                             |             | |                  ChatTile               | |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                                             |             | |                  ChatTile               | |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    |                                             |             | |                  ChatTile               | |    */
/*    |                                             |             |  -----------------------------------------  |    */
/*    | |-----------------------------------------| |              ---------------------------------------------     */
/*    | |                BottomNavBar             | |                                                                */
/*    | | |-------| |-------| |-------| |-------| | |                                                                */
/*    | | |NavBar | |NavBar | |NavBar | |NavBar | | |                                                                */
/*    | | | Item  | | Item  | | Item  | | Item  | | |                                                                */
/*    | | |-------| |-------| |-------| |-------| | |                                                                */
/*    | |-----------------------------------------| |                                                                */
/*    |---------------------------------------------|                                                                */
