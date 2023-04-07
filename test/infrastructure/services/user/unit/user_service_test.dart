import 'package:flutter_test/flutter_test.dart';
import 'package:ui/domain/entities/user.dart';
import 'package:ui/domain/services/user_service_interface.dart';
import 'package:ui/infrastructure/services/user_service.dart';

void main() {
  late IUserService userService;
  const User john = User(
    email: 'johndoe@example.com',
    name: 'John',
    surname: 'Doe',
    password: 'johndoe',
  );
  const User jane = User(
    email: 'janedoe@example.com',
    name: 'Jane',
    surname: 'Doe',
    password: 'janedoe',
  );
  final User updatedJohn = User(
    email: john.email,
    name: 'Updated John',
    surname: 'Updated Doe',
    password: john.password,
  );

  setUp(() async {
    userService = UserService();
    await userService.createUser(john);
  });

  tearDown(() async {
    userService.deleteUserByEmail(john.email);
  });

  group('UserService', () {
    group('getUsers', () {
      test('returns list of users on success', () async {
        // Act
        final users = await userService.getUsers();

        // Assert
        // It has to be modified because now it is been used the same database for
        // production and for testing
        expect(users.length, equals(4));
        expect(users.last.email, john.email);
        expect(users.last.name, john.name);
        expect(users.last.surname, john.surname);
      });
    });

    group('getUserByEmail', () {
      test('returns user on success', () async {
        // Act
        final user = await userService.getUserByEmail(john.email);

        // Assert
        expect(user.email, 'johndoe@example.com');
        expect(user.name, 'John');
        expect(user.surname, 'Doe');
      });

      test('throws exception on failure', () async {
        expect(() => userService.getUserByEmail(jane.email), throwsException);
      });
    });

    group('createUser', () {
      test('creates a new user and adds it to the list', () async {
        // Act
        final initialUsers = await userService.getUsers();
        await userService.createUser(jane);
        final updatedUsers = await userService.getUsers();

        // Assert
        expect(updatedUsers.length, initialUsers.length + 1);
        expect(updatedUsers.last.email, 'janedoe@example.com');
        expect(updatedUsers.last.name, 'Jane');
        expect(updatedUsers.last.surname, 'Doe');
      });

      test('throws exception on failure', () async {
        expect(() => userService.createUser(john), throwsException);
      });
    });

    group('updateUser', () {
      test('returns message on success', () async {
        // Act
        final user =
            await userService.updateUserByEmail(john.email, updatedJohn);
        final johnAfterUpdate = await userService.getUserByEmail(john.email);

        // Assert
        expect(user.name, johnAfterUpdate.name);
        expect(user.surname, johnAfterUpdate.surname);
      });

      test('throws exception on failure', () async {
        expect(() => userService.updateUserByEmail(jane.email, updatedJohn),
            throwsException);
      });
    });

    group('deleteUserByEmail', () {
      test('delete user on success', () async {
        // Act
        await userService.deleteUserByEmail(john.email);

        // Assert
        expect(() => userService.getUserByEmail(john.email), throwsException);
      });

      test('throws exception on failure', () async {
        expect(
            () => userService.deleteUserByEmail(jane.email), throwsException);
      });
    });
  });
}
