abstract class Failure {
  final String message;
  Failure(this.message);

  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

class BadRequestFailure extends Failure {
  BadRequestFailure(super.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class ParsingFailure extends Failure {
  ParsingFailure(super.message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}
