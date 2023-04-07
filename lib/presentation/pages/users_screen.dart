import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ui/domain/entities/user.dart';
import 'package:ui/domain/services/user_service_interface.dart';
import 'package:ui/infrastructure/utilities/helpers.dart';
import 'package:ui/presentation/styles/logger.dart';
import 'package:ui/presentation/widgets/avatar.dart';
import 'package:ui/presentation/widgets/custom_icon_button.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  UsersScreenState createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen> {
  final _userService = GetIt.instance.get<IUserService>();

  Future<List<User>>? _users;

  @override
  void initState() {
    super.initState();
    _users = _userService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        leading: const CustomIconButton.back(),
      ),
      body: FutureBuilder<List<User>>(
        future: _users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isNotEmpty) {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final User user = users[index];
                  return ChatTile(user: user);
                },
              );
            } else if (snapshot.hasError) {
              Logger.error('Error loading users: ${snapshot.error}');
              return Center(
                child: Text('Error loading users: ${snapshot.error}'),
              );
            } else {
              Logger.warning('No users found');
              return const Center(
                child: Text(
                  'No users found',
                ),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Logger.debug('TODO chat button'),
      child: Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: .2,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Avatar.medium(
                  url: Helpers.randomPictureUrl(),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '${user.name} ${user.surname}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          letterSpacing: 0.2,
                          wordSpacing: 1.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    SizedBox(
                      height: 4,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
