import 'package:flutter/material.dart';
import 'package:ui/domain/entities/organization.dart';
import 'package:intl/intl.dart';

@immutable
class Event {
  final int? id;
  final String title;
  final DateTime date;
  final String time;
  final String venue;
  final int? ticketLimit;
  final int organizationId;
  final Organization? organization;

  // Constructor
  const Event({
    this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    this.ticketLimit,
    required this.organizationId,
    this.organization,
  });

  // Factory method to create a new instance from a Map (fromJson)
  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      date: DateFormat("dd-MM-yyyy").parse(json['date']),
      time: json['time'],
      venue: json['venue'],
      ticketLimit: json['ticket_limit'],
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
      'organization_id': organizationId,
    };
  }
}
