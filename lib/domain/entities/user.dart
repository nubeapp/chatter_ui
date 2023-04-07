import 'package:flutter/material.dart';

@immutable
class User {
  final String name;
  final String email;
  final String surname;
  final String? password;
  final String? profileImage;

  const User({
    required this.email,
    required this.name,
    required this.surname,
    this.password,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json['email'],
        name: json['name'],
        surname: json['surname'],
        profileImage: json['profile_image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['surname'] = surname;
    data['password'] = password;
    data['profile_image'] = profileImage;
    return data;
  }
}
