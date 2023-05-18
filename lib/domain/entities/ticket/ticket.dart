import 'package:flutter/material.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/entities/ticket/ticket_status.dart';
import 'package:ui/domain/entities/user.dart';

@immutable
class Ticket {
  final int? id;
  final double price;
  final String reference;
  final TicketStatus status;
  final int? eventId;
  final int? userId;
  final int? orderId;
  final Event? event;
  final User? user;
  final Order? order;

  const Ticket(
      {this.id,
      required this.price,
      required this.reference,
      required this.status,
      this.eventId,
      this.userId,
      this.orderId,
      this.event,
      this.user,
      this.order});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
        id: json['id'],
        price: json['price'],
        reference: json['reference'],
        status: TicketStatus.values.firstWhere(
          (e) => e.name == json['status'],
          orElse: () => TicketStatus.AVAILABLE,
        ),
        eventId: json['event_id'],
        userId: json['user_id'],
        orderId: json['order_id'],
        event: Event.fromJson(json['event']),
        user: User.fromJson(json['user']),
        order: Order.fromJson(json['order']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'event_id': eventId,
      'reference': reference,
      'status': status.name,
    };
  }
}
