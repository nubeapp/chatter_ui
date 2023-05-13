/*

--------------------------------------------------------------------------------

POST User

{
    "email": "alvarolopsi@gmail.com",
    "name": "Alvaro",
    "surname": "Lopez Sierra",
    "password": "alvarolopsi"
}
{
    "email": "rociiocs.00@gmail.com",
    "name": "Rocio",
    "surname": "Chen Sun",
    "password": "rociiocs.00"
}
{
    "email": "miglop99@gmail.com",
    "name": "Miguel Angel",
    "surname": "Lopez Lopez",
    "password": "miglop99"
}

--------------------------------------------------------------------------------

POST Organization

{
    "name": "Universal Music Spain"
}
{
    "name": "Warner Bros Music"
}
{
    "name": "Sony Entertainment"
}

--------------------------------------------------------------------------------

POST Event

{
    "title": "Rosalia Concert",
    "date": "2023-02-14T18:00:00.000Z",
    "time": "18:00",
    "venue": "Wizink Center",
    "ticket_limit": 5,
    "ticket_available": 5,
    "organization_id": 1
}
{
    "title": "Bad Bunny Concert",
    "date": "2023-04-20T18:00:00.000Z",
    "time": "18:00",
    "venue": "Wizink Center",
    "ticket_limit": 5,
    "ticket_available": 5,
    "organization_id": 2
}
{
    "title": "Antonio Díaz, El Mago Pop",
    "date": "2023-12-07T21:00:00.000Z",
    "time": "21:00",
    "venue": "Teatro Antón Martín",
    "ticket_limit": 5,
    "ticket_available": 5,
    "organization_id": 3
}
{
    "title": "Lola Indigo en concierto",
    "date": "2023-04-20T21:00:00.000Z",
    "time": "21:00",
    "venue": "Wizink Center",
    "ticket_limit": 5,
    "ticket_available": 5,
    "organization_id": 2
}
{
    "title": "Blake en concierto",
    "date": "2023-02-14T19:00:00.000Z",
    "time": "19:00",
    "venue": "Sala8",
    "ticket_limit": 5,
    "ticket_available": 5,
    "organization_id": 1
}

--------------------------------------------------------------------------------

POST Tickets

[
    {
        "reference": "1RPGC7K5LWKLP3X9VW76",
        "price": 50.0,
        "event_id": 1
    },
    {
        "reference": "7ODG4K16FL4N4W4JH43N",
        "price": 50.0,
        "event_id": 1
    },
    {
        "reference": "N1S9S9HJQFEKZV0QUY4K",
        "price": 50.0,
        "event_id": 1
    },
    {
        "reference": "50W8LLE0G7KZSV1H28GS",
        "price": 50.0,
        "event_id": 1
    },
    {
        "reference": "2Z5V5Z08FX2CJ7GYZA68",
        "price": 50.0,
        "event_id": 1
    },
    {
        "reference": "7IW0MG68DW3V7TY5O57O",
        "price": 90.0,
        "event_id": 2
    },
    {
        "reference": "6HX3D3G3W6DN3J6U7Q00",
        "price": 90.0,
        "event_id": 2
    },
    {
        "reference": "X9I6U1N6ZM1L1F2N25L2",
        "price": 90.0,
        "event_id": 2
    },
    {
        "reference": "6N0E6J89B9X1N0K8M7I",
        "price": 90.0,
        "event_id": 2
    },
    {
        "reference": "C3M3J8O3W7O2A2Q2E9A",
        "price": 90.0,
        "event_id": 2
    },
    {
        "reference": "R6L7B6Z1Y6K7J6Q2W6A",
        "price": 70.0,
        "event_id": 3
    },
    {
        "reference": "T6T1T9T8T8W4N4Z4Y4Y",
        "price": 70.0,
        "event_id": 3
    },
    {
        "reference": "M4W4M7H5B1E4B9D9Q2",
        "price": 70.0,
        "event_id": 3
    },
    {
        "reference": "Z5P5Z5V7D5R5R5V7F5",
        "price": 70.0,
        "event_id": 3
    },
    {
        "reference": "P7X3B5N5O7K2Q2C2R7",
        "price": 70.0,
        "event_id": 3
    },
    {
        "reference": "O8H1O3J3G3M3I3O8L3",
        "price": 30.0,
        "event_id": 4
    },
    {
        "reference": "K4J4Z4D4Z4W4D4F4F4",
        "price": 30.0,
        "event_id": 4
    },
    {
        "reference": "I8M8K8L8D8R8G8J8F8",
        "price": 30.0,
        "event_id": 4
    },
    {
        "reference": "Q9D9T9L9B9T9K9T9T9",
        "price": 30.0,
        "event_id": 4
    },
    {
        "reference": "A7T7G7C7X7M7O7J7F7",
        "price": 30.0,
        "event_id": 4
    },
        {
        "reference": "N1O1V1P1A1N1L1F1O1",
        "price": 15.0,
        "event_id": 5
    },
    {
        "reference": "D1C1J1H1O1C1I1L1R1",
        "price": 15.0,
        "event_id": 5
    },
    {
        "reference": "R2S2W2E2V2R2M2S2S2",
        "price": 15.0,
        "event_id": 5
    },
    {
        "reference": "G5V5G5D5L5V5J5D5F5",
        "price": 15.0,
        "event_id": 5
    },
    {
        "reference": "K6Z6V6N6G6L6V6D6L6",
        "price": 15.0,
        "event_id": 5
    }
]


 */