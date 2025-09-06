class UnknownException implements Exception {
  final String message;
  UnknownException([this.message = 'Unknown error']);

  @override
  String toString() => 'UnknownException: $message';
}

class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Server error']);

  @override
  String toString() => 'ServerException: $message';
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException([this.message = 'Not found']);

  @override
  String toString() => 'NotFoundException: $message';
}
