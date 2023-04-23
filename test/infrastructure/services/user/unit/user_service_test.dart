import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:ui/domain/entities/user.dart';
import 'package:ui/domain/services/user_service_interface.dart';
import 'package:ui/infrastructure/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import 'user_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late IUserService userService;
  const String API_BASE_URL = 'http://0.0.0.0:8000/users';
  // const User john = User(
  //   email: 'johndoe@example.com',
  //   name: 'John',
  //   surname: 'Doe',
  //   password: 'johndoe',
  // );
  // const User jane = User(
  //   email: 'janedoe@example.com',
  //   name: 'Jane',
  //   surname: 'Doe',
  //   password: 'janedoe',
  // );
  // final User updatedJohn = User(
  //   email: john.email,
  //   name: 'Updated John',
  //   surname: 'Updated Doe',
  //   password: john.password,
  // );

  // setUp(() {
  // await userService.createUser(john);
  // });

  // tearDown(() async {
  // userService.deleteUserByEmail(john.email);
  // });

  group('UserService', () {
    group('Get Users', () {
      test('getUsers returns a list of users', () async {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.get(Uri.parse(API_BASE_URL))).thenAnswer((_) async =>
            http.Response(
                '[{"id": 1, "name": "John", "surname": "Doe", "email": "johndoe@example.com"}, {"id": 2, "name": "Jane", "surname": "Smith", "email": "janesmith@example.com"}]',
                200));

        final users = await userService.getUsers();

        expect(users, isA<List<User>>());
        expect(users.length, equals(2));
        expect(users[0].id, equals(1));
        expect(users[1].id, equals(2));
        expect(users[0].email, 'johndoe@example.com');
        expect(users[1].email, 'janesmith@example.com');
        expect(users[0].name, 'John');
        expect(users[1].name, 'Jane');
        expect(users[0].surname, 'Doe');
        expect(users[1].surname, 'Smith');

        verify(mockClient.get(Uri.parse(API_BASE_URL))).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(mockClient.get(Uri.parse(API_BASE_URL)))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(userService.getUsers(), throwsException);

        verify(mockClient.get(Uri.parse(API_BASE_URL))).called(1);
      });

      // test('returns list of users on success', () async {
      //   // Act
      //   final users = await userService.getUsers();

      //   // Assert
      //   // It has to be modified because now it is been used the same database for
      //   // production and for testing
      //   expect(users.length, equals(4));
      //   expect(users.last.email, john.email);
      //   expect(users.last.name, john.name);
      //   expect(users.last.surname, john.surname);
      // });
    });

    group('Get Users By', () {
      test('getUserByEmail returns a user', () async {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.get(Uri.parse('$API_BASE_URL/$mockEmail'))).thenAnswer(
            (_) async => http.Response(
                '{"id": 1, "name": "John", "surname": "Doe", "email": "johndoe@example.com"}',
                200));

        final user = await userService.getUserByEmail(mockEmail);

        expect(user, isA<User>());
        expect(user.id, equals(1));
        expect(user.email, 'johndoe@example.com');
        expect(user.name, 'John');
        expect(user.surname, 'Doe');

        verify(mockClient.get(Uri.parse('$API_BASE_URL/$mockEmail'))).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(mockClient.get(Uri.parse('$API_BASE_URL/$mockEmail')))
            .thenAnswer((_) async => http.Response('Not Found', 404));

        expect(userService.getUserByEmail(mockEmail), throwsException);

        verify(mockClient.get(Uri.parse('$API_BASE_URL/$mockEmail'))).called(1);
      });

      //   test('returns user on success', () async {
      //     // Act
      //     final user = await userService.getUserByEmail(john.email);

      //     // Assert
      //     expect(user.email, 'johndoe@example.com');
      //     expect(user.name, 'John');
      //     expect(user.surname, 'Doe');
      //   });

      //   test('throws exception on failure', () async {
      //     expect(() => userService.getUserByEmail(jane.email), throwsException);
      //   });
    });

    group('Create Users', () {
      test('createUser returns a user', () async {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);
        const User mockUser =
            User(email: 'johndoe@example.com', name: 'John', surname: 'Doe');

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockUser.toJson()),
        )).thenAnswer((_) async => http.Response(
            '{"id": 1, "name": "John", "surname": "Doe", "email": "johndoe@example.com"}',
            201));

        final user = await userService.createUser(mockUser);

        expect(user, isA<User>());
        expect(user.id, equals(1));
        expect(user.email, 'johndoe@example.com');
        expect(user.name, 'John');
        expect(user.surname, 'Doe');

        verify(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockUser.toJson()),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);
        const User mockUser =
            User(email: 'johndoe@example.com', name: 'John', surname: 'Doe');

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockUser.toJson()),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(userService.createUser(mockUser), throwsException);

        verify(mockClient.post(
          Uri.parse(API_BASE_URL),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockUser.toJson()),
        )).called(1);
      });

      //   test('creates a new user and adds it to the list', () async {
      //     // Act
      //     final initialUsers = await userService.getUsers();
      //     await userService.createUser(jane);
      //     final updatedUsers = await userService.getUsers();

      //     // Assert
      //     expect(updatedUsers.length, initialUsers.length + 1);
      //     expect(updatedUsers.last.email, 'janedoe@example.com');
      //     expect(updatedUsers.last.name, 'Jane');
      //     expect(updatedUsers.last.surname, 'Doe');
      //   });

      //   test('throws exception on failure', () async {
      //     expect(() => userService.createUser(john), throwsException);
      //   });
    });

    group('Update Users', () {
      test('updateUserByEmail returns a user', () async {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';
        const User mockUser = User(
          email: 'johndoe@example.com',
          name: 'John Updated',
          surname: 'Doe Updated',
        );

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockUser.toJson()),
        )).thenAnswer((_) async => http.Response(
            '{"id": 1, "name": "John Updated", "surname": "Doe Updated", "email": "johndoe@example.com"}',
            200));

        final user = await userService.updateUserByEmail(mockEmail, mockUser);

        expect(user, isA<User>());
        expect(user.id, equals(1));
        expect(user.email, 'johndoe@example.com');
        expect(user.name, 'John Updated');
        expect(user.surname, 'Doe Updated');

        verify(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockUser.toJson()),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';
        const User mockUser = User(
          email: 'johndoe@example.com',
          name: 'John Updated',
          surname: 'Doe Updated',
        );

        // Use Mockito to return an unsuccessful response when it calls the
        // provided http.Client.
        when(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockUser.toJson()),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(userService.updateUserByEmail(mockEmail, mockUser),
            throwsException);

        verify(mockClient.put(
          Uri.parse('$API_BASE_URL/$mockEmail'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(mockUser.toJson()),
        )).called(1);
      });
      //   test('returns message on success', () async {
      //     // Act
      //     final user =
      //         await userService.updateUserByEmail(john.email, updatedJohn);
      //     final johnAfterUpdate = await userService.getUserByEmail(john.email);

      //     // Assert
      //     expect(user.name, johnAfterUpdate.name);
      //     expect(user.surname, johnAfterUpdate.surname);
      //   });

      //   test('throws exception on failure', () async {
      //     expect(() => userService.updateUserByEmail(jane.email, updatedJohn),
      //         throwsException);
      //   });
    });

    group('Delete Users', () {
      test('deleteUserByEmail is called once', () async {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEmail'),
        )).thenAnswer((_) async => http.Response('[]', 204));

        await userService.deleteUserByEmail(mockEmail);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEmail'),
        )).called(1);
      });

      test('throws an exception if the http call completes with an error', () {
        final mockClient = MockClient();
        userService = UserService(client: mockClient);
        const String mockEmail = 'johndoe@example.com';

        // Use Mockito to return a successful response when it calls the
        // provided http.Client.
        when(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEmail'),
        )).thenAnswer((_) async => http.Response('Not Found', 404));

        expect(userService.deleteUserByEmail(mockEmail), throwsException);

        verify(mockClient.delete(
          Uri.parse('$API_BASE_URL/$mockEmail'),
        )).called(1);
      });
      //   test('delete user on success', () async {
      //     // Act
      //     await userService.deleteUserByEmail(john.email);

      //     // Assert
      //     expect(() => userService.getUserByEmail(john.email), throwsException);
      //   });

      //   test('throws exception on failure', () async {
      //     expect(
      //         () => userService.deleteUserByEmail(jane.email), throwsException);
      //   });
    });
  });
}
