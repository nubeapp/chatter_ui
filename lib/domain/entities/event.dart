import 'package:flutter/material.dart';
import 'package:ui/domain/entities/organization.dart';
import 'package:intl/intl.dart';

@immutable
class Event {
  final int? id;
  final String title;
  final DateTime date;
  final String venue;
  final int ticketLimit;
  final int ticketAvailable;
  final int organizationId;
  final Organization? organization;

  // Constructor
  const Event({
    this.id,
    required this.title,
    required this.date,
    required this.venue,
    required this.ticketLimit,
    required this.ticketAvailable,
    required this.organizationId,
    this.organization,
  });

  // Factory method to create a new instance from a Map (fromJson)
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      date: DateFormat("dd-MM-yyyy HH:mm").parse(json['date']),
      venue: json['venue'],
      ticketLimit: json['ticket_limit'],
      ticketAvailable: json['ticket_available'],
      organizationId: json['organization_id'],
      organization: Organization.fromJson(json['organization']),
    );
  }

  // Method to convert the instance to a Map (toJson)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toString(),
      'venue': venue,
      'ticket_limit': ticketLimit,
      'ticket_available': ticketAvailable,
      'organization_id': organizationId,
    };
  }
}
