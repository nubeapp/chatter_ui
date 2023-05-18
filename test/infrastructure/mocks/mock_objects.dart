import 'package:intl/intl.dart';
import 'package:ui/domain/entities/code.dart';
import 'package:ui/domain/entities/credentials.dart';
import 'package:ui/domain/entities/email_data.dart';
import 'package:ui/domain/entities/event.dart';
import 'package:ui/domain/entities/order.dart';
import 'package:ui/domain/entities/user.dart';

final mockEventObject = Event(
  title: 'Bad Bunny Concert',
  date: DateFormat("dd-MM-yyyy").parse("07-12-2023"),
  time: '18:00',
  venue: 'Wizink Center',
  ticketLimit: 1000,
  organizationId: 1,
);

const mockCredentialsObject = Credentials(
  email: 'johndoe@example.com',
  password: 'johndoe',
);

const mockCodeObject = Code(
  email: 'johndoe@example.com',
  code: '12345',
);

const mockEmailDataObject = EmailData(
  email: 'johndoe@example.com',
  name: 'John',
  code: '12345',
);

const mockUserObject = User(
  email: 'johndoe@example.com',
  name: 'John',
  surname: 'Doe',
);

const mockOrderObject = Order(
  eventId: 1,
  quantity: 1,
);
