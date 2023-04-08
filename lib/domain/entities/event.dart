import 'package:flutter/material.dart';

@immutable
class Event {
  final int? id;
  final int ownerId;
  final String title;
  final bool completed;

  // Constructor
  const Event({
    this.id,
    required this.ownerId,
    required this.title,
    this.completed = false,
  });

  // Factory method to create a new instance from a Map (fromJson)
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      ownerId: json['owner_id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  // Method to convert the instance to a Map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'owner_id': ownerId,
      'title': title,
      'completed': completed,
    };
  }
}
