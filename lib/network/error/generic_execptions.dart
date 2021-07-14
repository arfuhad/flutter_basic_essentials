class GenericExceptions implements Exception {
  final _message;
  final _prefix;

  GenericExceptions([this._prefix, this._message]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends GenericExceptions {
  FetchDataException([String? message])
      : super("Error During Communication: ", message);
}

class BadRequestException extends GenericExceptions {
  BadRequestException([String? message]) : super("Invalid Request: ", message);
}

class NotFoundException extends GenericExceptions {
  NotFoundException([String? message]) : super("Not Found: ", message);
}

class UnauthorisedException extends GenericExceptions {
  UnauthorisedException([String? message]) : super("Unauthorised: ", message);
}

class InvalidInputException extends GenericExceptions {
  InvalidInputException([String? message]) : super("Invalid Input: ", message);
}

class CacheException extends GenericExceptions {
  CacheException([String? message]) : super("Caching Error: ", message);
}

class ServerException extends GenericExceptions {
  ServerException([String? message]) : super("Server Request Error: ", message);
}

class NetworkException extends GenericExceptions {
  NetworkException([String? message]) : super("Network Error: ", message);
}
