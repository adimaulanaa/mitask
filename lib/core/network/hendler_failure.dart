import 'package:equatable/equatable.dart';

/// Base Failure class for handling all types of errors
abstract class Failure extends Equatable {
  const Failure({
    this.message = '',
    this.error = '',
  });

  final String message;
  final String error;

  @override
  List<Object> get props => [message, error];
}

// ───────────────────────────────
// Specific Failure Types
// ───────────────────────────────

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    super.message,
    super.error,
    this.statusCode,
  });

  @override
  List<Object> get props => [message, error, statusCode ?? ''];
}

class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message,
    super.error,
  });
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    super.message,
    super.error,
  });
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message,
    super.error,
  });
}

class InvalidCredentialFailure extends Failure {
  const InvalidCredentialFailure({
    super.message,
    super.error,
  });
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message,
    super.error,
  });
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({
    super.message,
    super.error,
  });
}

class UnauthorisedFailure extends Failure {
  const UnauthorisedFailure({
    super.message,
    super.error,
  });
}

class FetchDataFailure extends Failure {
  const FetchDataFailure({
    super.message,
    super.error,
  });
}
