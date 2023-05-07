/* 
  +----------------------------+
  |    Mock Ticket Responses   |
  +----------------------------+
*/

const mockTicketListResponse = [
  {
    "id": 1,
    "price": 80.0,
    "reference": "001AUMS20230426ABAD",
    "event_id": 1,
    "organization_id": 1,
    "event": {
      "id": 1,
      "title": "Bad Bunny Concert",
      "date": "07-12-2023",
      "time": "18:00",
      "venue": "Wizink Center",
      "ticket_limit": 1000,
      "ticket_available": 999,
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
    "event_id": 2,
    "organization_id": 1,
    "event": {
      "id": 2,
      "title": "Rosalia Concert",
      "date": "14-12-2023",
      "time": "18:00",
      "venue": "Wizink Center",
      "ticket_limit": 1000,
      "ticket_available": 999,
      "organization_id": 1,
      "organization": {
        "id": 1,
        "name": "UNIVERSAL MUSIC SPAIN",
      },
    }
  }
];

const mockTicketResponse = {
  "id": 1,
  "price": 80.0,
  "reference": "001AUMS20230426ABAD",
  "event_id": 1,
  "organization_id": 1,
  "event": {
    "id": 1,
    "title": "Bad Bunny Concert",
    "date": "07-12-2023",
    "time": "18:00",
    "venue": "Wizink Center",
    "ticket_limit": 1000,
    "ticket_available": 999,
    "organization_id": 1,
    "organization": {
      "id": 1,
      "name": "UNIVERSAL MUSIC SPAIN",
    },
  }
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
    "ticket_available": 999,
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
    "ticket_available": 999,
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
  "ticket_available": 999,
  "organization_id": 1,
  "organization": {
    "id": 1,
    "name": "UNIVERSAL MUSIC SPAIN",
  },
};

/* 
  +----------------------------+
  |     Mock Auth Responses    |
  +----------------------------+
*/

const mockCredentialsResponse = {
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
  {"email": "johndoe@example.com", "code": "12345"},
  {"email": "janesmith@example.com", "code": "67890"}
];

const mockCodeResponse = {
  "email": "johndoe@example.com",
  "code": "12345",
};

/* 
  +----------------------------+
  |     Mock Code Responses    |
  +----------------------------+
*/

const mockUserListResponse = [
  {
    "id": 1,
    "name": "John",
    "surname": "Doe",
    "email": "johndoe@example.com",
  },
  {
    "id": 2,
    "name": "Jane",
    "surname": "Smith",
    "email": "janesmith@example.com"
  }
];

const mockUserResponse = {
  "id": 1,
  "name": "John",
  "surname": "Doe",
  "email": "johndoe@example.com"
};
/* 
  +----------------------------+
  | Mock Event Queue Responses |
  +----------------------------+
*/

const mockQueueResponse = [
  {
    "user_id": 1,
    "event_id": 1,
    "user": {
      "id": 1,
      "name": "John",
      "surname": "Doe",
      "email": "johndoe@example.com"
    },
  },
  {
    "user_id": 2,
    "event_id": 1,
    "user": {
      "id": 2,
      "name": "Jane",
      "surname": "Smith",
      "email": "janesmith@example.com"
    }
  },
  {
    "user_id": 1,
    "event_id": 2,
    "user": {
      "id": 1,
      "name": "John",
      "surname": "Doe",
      "email": "johndoe@example.com"
    }
  },
];
