import 'package:flutter/material.dart';

@immutable
class User {
  final int? id;
  final String name;
  final String email;
  final String surname;
  final String? password;
  final String? profileImage;

  const User({
    this.id,
    required this.email,
    required this.name,
    required this.surname,
    this.password,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        email: json['email'],
        name: json['name'],
        surname: json['surname'],
        profileImage: json['profile_image']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'surname': surname,
      'password': password,
      'profile_image': profileImage
    };
  }
}
