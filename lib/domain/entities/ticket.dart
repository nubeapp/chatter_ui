import 'package:flutter/material.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/user.dart';

@immutable
class Ticket {
  final int? id;
  final double price;
  final int userId;
  final int eventId;
  final int organizationId;
  final String reference;
  final User user;
  final Event event;

  const Ticket({
    this.id,
    required this.price,
    required this.userId,
    required this.eventId,
    required this.organizationId,
    required this.reference,
    required this.user,
    required this.event,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['id'],
        price: json['price'],
        userId: json['user_id'],
        eventId: json['event_id'],
        organizationId: json['organization_id'],
        reference: json['reference'],
        user: User.fromJson(json['user']),
        event: Event.fromJson(json['event']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'user_id': userId,
      'event_id': eventId,
      'reference': reference,
    };
  }
}
