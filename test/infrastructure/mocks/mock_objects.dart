import 'package:intl/intl.dart';
import 'package:ui/domain/entities/event.dart';

final mockEventObject = Event(
  title: 'Bad Bunny Concert',
  code: 'BAD',
  date: DateFormat("dd-MM-yyyy HH:mm").parse("07-12-2023 18:00"),
  venue: 'Wizink Center, Av. de Felipe II',
  ticketLimit: 1000,
  ticketAvailable: 1000,
  organizationId: 1,
);
