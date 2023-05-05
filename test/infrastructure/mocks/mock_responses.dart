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
    "user_id": 1,
    "event_id": 1,
    "organization_id": 1,
    "user": {
      "id": 1,
      "name": "John",
      "surname": "Doe",
      "email": "johndoe@example.com"
    },
    "event": {
      "id": 1,
      "title": "Bad Bunny Concert",
      "date": "07-12-2023 18:00",
      "venue": "Wizink Center, Av. de Felipe II",
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
    "user_id": 1,
    "event_id": 2,
    "organization_id": 1,
    "user": {
      "id": 1,
      "name": "John",
      "surname": "Doe",
      "email": "johndoe@example.com"
    },
    "event": {
      "id": 2,
      "title": "Rosalia Concert",
      "date": "14-12-2023 18:00",
      "venue": "Wizink Center, Av. de Felipe II",
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
  "user_id": 1,
  "event_id": 1,
  "organization_id": 1,
  "user": {
    "id": 1,
    "name": "John",
    "surname": "Doe",
    "email": "johndoe@example.com"
  },
  "event": {
    "id": 1,
    "title": "Bad Bunny Concert",
    "date": "07-12-2023 18:00",
    "venue": "Wizink Center, Av. de Felipe II",
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
    "date": "07-12-2023 18:00",
    "venue": "Wizink Center, Av. de Felipe II",
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
    "date": "14-12-2023 18:00",
    "venue": "Wizink Center, Av. de Felipe II",
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
  "venue": "Wizink Center, Av. de Felipe II",
  "date": "07-12-2023 18:00",
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
