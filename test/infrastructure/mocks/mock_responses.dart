import 'package:ui/domain/entities/ticket/ticket_status.dart';

/* 
  +----------------------------+
  |     Mock User Responses    |
  +----------------------------+
*/

const mockUserListResponse = [
  {
    "id": 1,
    "name": "John",
    "surname": "Doe",
    "email": "johndoe@example.com",
  },
  {"id": 2, "name": "Jane", "surname": "Smith", "email": "janesmith@example.com"}
];

const mockUserResponse = {
  "id": 1,
  "name": "John",
  "surname": "Doe",
  "email": "johndoe@example.com",
};

/* 
  +----------------------------+
  |     Mock Auth Responses    |
  +----------------------------+
*/

const mockTokenResponse = {
  "accessToken":
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c",
  "type": "bearer"
};

/* 
  +----------------------------+
  |     Mock Code Responses    |
  +----------------------------+
*/

const mockCodeListResponse = [
  {
    "email": "johndoe@example.com",
    "code": "12345",
  },
  {
    "email": "janesmith@example.com",
    "code": "67890",
  }
];

const mockCodeResponse = {
  "email": "johndoe@example.com",
  "code": "12345",
};

/* 
  +----------------------------+
  |     Mock Event Responses   |
  +----------------------------+
*/

const mockEventListResponse = [
  {
    "id": 1,
    "title": "Bad Bunny Concert",
    "date": "07-12-2023",
    "time": "18:00",
    "venue": "Wizink Center",
    "ticket_limit": 1000,
    "organization_id": 1,
    "organization": {
      "id": 1,
      "name": "UNIVERSAL MUSIC SPAIN",
    },
  },
  {
    "id": 2,
    "title": "Rosalia Concert",
    "date": "14-12-2023",
    "time": "18:00",
    "venue": "Wizink Center",
    "ticket_limit": 1000,
    "organization_id": 1,
    "organization": {
      "id": 1,
      "name": "UNIVERSAL MUSIC SPAIN",
    },
  }
];

const mockEventResponse = {
  "id": 1,
  "title": "Bad Bunny Concert",
  "venue": "Wizink Center",
  "date": "07-12-2023",
  "time": "18:00",
  "ticket_limit": 1000,
  "organization_id": 1,
  "organization": {
    "id": 1,
    "name": "UNIVERSAL MUSIC SPAIN",
  },
};

/* 
  +----------------------------+
  |    Mock Ticket Responses   |
  +----------------------------+
*/

final mockTicketListResponse = [
  {
    "id": 1,
    "price": 80.0,
    "reference": "001AUMS20230426ABAD",
    "status": TicketStatus.SOLD.name,
    "event_id": 1,
    "event": {
      "id": 1,
      "title": "Bad Bunny Concert",
      "date": "07-12-2023",
      "time": "18:00",
      "venue": "Wizink Center",
      "organization_id": 1,
      "organization": {
        "id": 1,
        "name": "UNIVERSAL MUSIC SPAIN",
      },
    }
  },
  {
    "id": 2,
    "price": 60.0,
    "reference": "001AUMS20230426AROS",
    "status": TicketStatus.SOLD.name,
    "event_id": 2,
    "event": {
      "id": 2,
      "title": "Rosalia Concert",
      "date": "14-12-2023",
      "time": "18:00",
      "venue": "Wizink Center",
      "organization_id": 1,
      "organization": {
        "id": 1,
        "name": "UNIVERSAL MUSIC SPAIN",
      },
    }
  }
];

final mockTicketResponse = {
  "id": 1,
  "price": 80.0,
  "reference": "001AUMS20230426ABAD",
  "status": TicketStatus.SOLD.name,
  "event_id": 1,
  "event": {
    "id": 1,
    "title": "Bad Bunny Concert",
    "date": "07-12-2023",
    "time": "18:00",
    "venue": "Wizink Center",
    "organization_id": 1,
    "organization": {
      "id": 1,
      "name": "UNIVERSAL MUSIC SPAIN",
    },
  }
};
