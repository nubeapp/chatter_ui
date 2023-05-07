import 'package:flutter/material.dart';
import 'package:ui/domain/entities/event.dart';

@immutable
class Ticket {
  final int? id;
  final double price;
  final String reference;
  final int eventId;
  final int organizationId;
  final Event event;

  const Ticket({
    this.id,
    required this.price,
    required this.reference,
    required this.eventId,
    required this.organizationId,
    required this.event,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['id'],
        price: json['price'],
        reference: json['reference'],
        eventId: json['event_id'],
        organizationId: json['organization_id'],
        event: Event.fromJson(json['event']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'event_id': eventId,
      'organization_id': organizationId,
      'reference': reference,
    };
  }
}
