import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ui/domain/entities/user.dart';
import 'package:ui/domain/services/user_service_interface.dart';
import 'package:ui/presentation/styles/logger.dart';

class UserService implements IUserService {
  static String get API_BASE_URL => 'http://0.0.0.0:8000/users';
  final http.Client client;

  UserService({required this.client});

  @override
  Future<List<User>> getUsers() async {
    try {
      Logger.debug('Requesting all users from the database...');
      final response = await client.get(Uri.parse(API_BASE_URL));

      if (response.statusCode == 200) {
        final responseData = json.decode(utf8.decode(response.bodyBytes)) as List<dynamic>;
        final List<User> users = responseData.map((json) => User.fromJson(json)).toList();
        Logger.info('Users have been retrieved successfully!');
        return users;
      } else {
        Logger.error('Failed to load users');
        throw Exception('Failed to load users');
      }
    } catch (e) {
      Logger.error('An error occurred while getting users: $e');
      throw Exception('Failed to load users');
    }
  }

  @override
  Future<User> getUserByEmail(String email) async {
    try {
      Logger.debug('Requesting user with email $email...');
      final response = await client.get(Uri.parse('$API_BASE_URL/$email'));

      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        final User user = User.fromJson(responseData);
        Logger.info('User with email ${user.email} has been retrieved successfully!');
        return user;
      } else {
        Logger.error('Failed to load user');
        throw Exception('Failed to load user');
      }
    } catch (e) {
      Logger.error('An error occurred while getting user: $e');
      throw Exception('Failed to load user');
    }
  }

  @override
  Future<User> createUser(User user) async {
    try {
      Logger.debug('Creating user with email ${user.email}...');
      final response = await client.post(
        Uri.parse(API_BASE_URL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201) {
        final dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
        final User newUser = User.fromJson(responseData);
        Logger.info('User with email ${newUser.email} has been created successfully!');
        return newUser;
      } else {
        Logger.error('Failed to create user');
        throw Exception('Failed to create user');
      }
    } catch (e) {
      Logger.error('An error occurred while creating user: $e');
      throw Exception('Failed to create user');
    }
  }

  @override
  Future<User> updateUserByEmail(String email, User user) async {
    try {
      Logger.debug('Updating user with email $email...');
      final response = await client.put(
        Uri.parse('$API_BASE_URL/$email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(utf8.decode(response.bodyBytes));
        final User updatedUser = User.fromJson(responseData);
        Logger.info('User with email $email has been updated successfully!');
        return updatedUser;
      } else {
        Logger.error('Failed to update user');
        throw Exception('Failed to update user');
      }
    } catch (e) {
      Logger.error('An error occurred while updating user: $e');
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<void> deleteUsers() async {
    try {
      Logger.debug('Deleting all users from the database...');
      final response = await client.delete(Uri.parse(API_BASE_URL));

      if (response.statusCode != 204) {
        Logger.error('Failed to delete users');
        throw Exception('Failed to delete users');
      }
      Logger.info('All users have been deleted successfully');
    } catch (e) {
      Logger.error('An error occurred while deleting users: $e');
      throw Exception('Failed to delete users');
    }
  }

  @override
  Future<void> deleteUserByEmail(String email) async {
    try {
      Logger.debug('Deleting user with email $email...');
      final response = await client.delete(Uri.parse('$API_BASE_URL/$email'));

      if (response.statusCode != 204) {
        Logger.error('Failed to delete user');
        throw Exception('Failed to delete user');
      }
      Logger.info('User with email $email has been deleted successfully!');
    } catch (e) {
      Logger.error('An error occurred while deleting user: $e');
      throw Exception('Failed to delete user');
    }
  }
}
