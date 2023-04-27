import 'package:flutter/material.dart';
import 'package:ui/domain/entities/user.dart';

@immutable
class EventQueueEntry {
  final int? id;
  final int userId;
  final int eventId;
  final User user;

  const EventQueueEntry({
    this.id,
    required this.userId,
    required this.eventId,
    required this.user,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'event_id': eventId,
    };
  }

  factory EventQueueEntry.fromJson(Map<String, dynamic> json) {
    return EventQueueEntry(
      id: json['id'],
      userId: json['user_id'],
      eventId: json['event_id'],
      user: User.fromJson(json['user']),
    );
  }
}
