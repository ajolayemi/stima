// ignore_for_file: public_member_api_docs, sort_constructors_first
sealed class AppException implements Exception {
  final String code;
  final String? message;
  final StackTrace? stackTrace;

  const AppException({required this.code, this.message, this.stackTrace});

  @override
  String toString() {
    String output = '($code) $message';

    if (stackTrace != null) {
      output += '\n\n$stackTrace';
    }

    return output;
  }
}

class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException({super.stackTrace})
    : super(code: 'app/email-already-in-use', message: 'Email already in use');
}

class UserNotFoundException extends AppException implements Exception {
  UserNotFoundException({super.stackTrace})
    : super(
        code: 'app/user-not-found',
        message:
            'User not found, check that you entered the right email and password',
      );
}

class IdenticalPasswordException extends AppException {
  IdenticalPasswordException({super.stackTrace})
    : super(
        code: 'app/identical-password',
        message: 'New password is the same as the old password',
      );
}

class PasswordTooShortException extends AppException {
  PasswordTooShortException({super.stackTrace})
    : super(code: 'app/password-too-short', message: 'Password is too short');
}

/// Indicates those exceptions that are caught, thrown but not communicated to user
/// For example, during google auth flow, should user cancel the flow, they're not told about that as they interrupted it themselves
class SilentException extends AppException {
  SilentException({super.stackTrace})
    : super(
        code: 'app/silent-error',
        message: 'An error caught but not communicated to user occurred',
      );
}

/// Indicates those exceptions that are caught, thrown but not communicated to user
/// For example, during google auth flow, should user cancel the flow, they're not told about that as they interrupted it themselves
class GenericException extends AppException {
  GenericException({super.stackTrace})
    : super(code: 'app/generic-error', message: 'A generic error occurred');
}

class ResetPasswordCodeExpiredException extends AppException {
  ResetPasswordCodeExpiredException({super.stackTrace})
    : super(
        code: 'app/reset-password-code-expired',
        message:
            'The provided confirmation code for password reset is invalid or has expired',
      );
}
