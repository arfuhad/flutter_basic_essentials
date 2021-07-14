import 'package:equatable/equatable.dart';

abstract class GenericFailure extends Equatable {
  final String? message;
  GenericFailure([this.message, List properties = const <dynamic>[]]);
}

// General failures
class NetworkFailure extends GenericFailure {
  final String? message;
  NetworkFailure([this.message, List properties = const <dynamic>[]])
      : super(message, properties) {
    print('network failure');
  }
  @override
  List<Object> get props => [message as String];
}

class ServerFailure extends GenericFailure {
  final String? message;
  ServerFailure([this.message, List properties = const <dynamic>[]])
      : super(message, properties) {
    print('server failure');
  }
  @override
  List<Object> get props => [message as String];
}

class CacheFailure extends GenericFailure {
  final String? message;
  CacheFailure([this.message, List properties = const <dynamic>[]])
      : super(message, properties) {
    print('cache failure');
  }
  @override
  List<Object> get props => [message as String];
}

class AuthenticationFailure extends GenericFailure {
  final String? message;
  AuthenticationFailure(this.message, [List properties = const <dynamic>[]])
      : super(message, properties) {
    print('authentication failure');
  }
  @override
  List<Object> get props => [message as String];
}

class RegsiterFailure extends GenericFailure {
  final String? message;
  RegsiterFailure(this.message, [List properties = const <dynamic>[]])
      : super(message, properties) {
    print('register failure');
  }
  @override
  List<Object> get props => [message as String];
}

class GeneralFailure extends GenericFailure {
  final String? message;
  GeneralFailure(this.message, [List properties = const <dynamic>[]])
      : super(message, properties) {
    print('general failure');
  }
  @override
  List<Object> get props => [message as String];
}
