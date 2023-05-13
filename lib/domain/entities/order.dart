import 'package:flutter/material.dart';
import 'package:ui/domain/entities/ticket.dart';

@immutable
class Order {
  final int? id;
  final int eventId;
  final int quantity;
  final List<Ticket>? tickets;

  const Order({
    this.id,
    required this.eventId,
    required this.quantity,
    this.tickets,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> ticketList = [];
    if (tickets != null) {
      ticketList = tickets!.map((t) => t.toJson()).toList();
    }

    return {
      'id': id,
      'eventId': eventId,
      'quantity': quantity,
      'tickets': ticketList,
    };
  }

  static Order fromJson(Map<String, dynamic> json) {
    List<Ticket>? ticketsList = [];
    if (json['tickets'] != null) {
      var ticketObjsJson = json['tickets'] as List<dynamic>;
      ticketsList = ticketObjsJson.map((t) => Ticket.fromJson(t)).toList();
    }

    return Order(
      id: json['id'],
      eventId: json['eventId'],
      quantity: json['quantity'],
      tickets: ticketsList,
    );
  }
}
