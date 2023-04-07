import 'package:flutter/material.dart';

@immutable
class Event {
  final int? id;
  final String ownerEmail;
  final String title;
  final bool completed;

  // Constructor
  const Event({
    this.id,
    required this.ownerEmail,
    required this.title,
    required this.completed,
  });

  // Factory method to create a new instance from a Map (fromJson)
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      ownerEmail: json['ownerEmail'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  // Method to convert the instance to a Map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerEmail': ownerEmail,
      'title': title,
      'completed': completed,
    };
  }
}
