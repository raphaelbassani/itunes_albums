abstract class Failure {
  final String message;
  const Failure(this.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'An unknown error occurred']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error, please try again later']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Requested resource was not found']);
}

class ParseFailure extends Failure {
  const ParseFailure([super.message = 'Error trying to parse on repository.']);
}
