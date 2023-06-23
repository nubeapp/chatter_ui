class EventTicketLimitException implements Exception {
  final String message;

  EventTicketLimitException(this.message);

  @override
  String toString() => message;
}

class UserTicketLimitException implements Exception {
  final String message;

  UserTicketLimitException(this.message);

  @override
  String toString() => message;
}

// Add more custom exceptions as needed
