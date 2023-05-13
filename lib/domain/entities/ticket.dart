import 'package:flutter/material.dart';
import 'package:ui/domain/entities/event.dart';

@immutable
class Ticket {
  final int? id;
  final double price;
  final String reference;
  final int? eventId;
  final Event? event;

  const Ticket({
    this.id,
    required this.price,
    required this.reference,
    this.eventId,
    this.event,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['id'],
        price: json['price'],
        reference: json['reference'],
        eventId: json['event_id'],
        event: Event.fromJson(json['event']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'event_id': eventId,
      'reference': reference,
    };
  }
}
