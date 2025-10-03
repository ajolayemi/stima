import 'package:stima/core/utils/validators/validators.dart';

/// Holds onto various form validation utilities
mixin AppFormValidatorMixin {
  final _nonEmptyValidator = NonEmptyStringValidator();

  // final _numberFieldsValidator = NumberValidators();

  final _emailValidator = EmailValidator();

  final _passwordUpperCaseValidator = PasswordUppercaseValidator();

  final _passwordLowerCaseValidator = PasswordLowercaseValidator();

  final _passwordDigitValidator = PasswordDigitValidator();

  final _passwordSpecialCharValidator = PasswordSpecialCharValidator();

  /// Helps in validating email fields from forms
  bool canSubmitEmail({required String email, String? initialValue}) {
    // If the email is the same as the initial value, we consider it valid
    if (initialValue != null &&
        email.toLowerCase() == initialValue.toLowerCase()) {
      return true;
    }

    return _nonEmptyValidator.isValid(email) && _emailValidator.isValid(email);
  }

  /// Gets the error key that will be used to show error message for email fields
  String? getEmailErrorKey({required String email, String? initialValue}) {
    if (email.isEmpty) {
      return 'validator_error_empty_email';
    } else if (!_emailValidator.isValid(email)) {
      return 'validator_error_invalid_email';
    }
    return null;
  }

  /// Holds the logic to validate whether can submit password field
  /// The constraints are:
  /// - non-empty
  /// - minimum length of the specified length
  /// - has at least one uppercase letter
  /// - has at least one lowercase letter
  /// - has at least one digit
  /// - has at least one special character
  bool canSubmitPassword({
    required String password,
    required int minLength,
    bool validateJustEmpty = false,
  }) {
    if (validateJustEmpty) {
      return _nonEmptyValidator.isValid(password);
    }

    final valid =
        _nonEmptyValidator.isValid(password) &&
        MinLengthStringValidator(minLength).isValid(password) &&
        _passwordUpperCaseValidator.isValid(password) &&
        _passwordLowerCaseValidator.isValid(password) &&
        _passwordDigitValidator.isValid(password) &&
        _passwordSpecialCharValidator.isValid(password);
    return valid;
  }

  /// Gets the error key that will be used to show error message for password fields
  String? getPasswordErrorKey({
    required String password,
    required int minLength,
    bool validateJustEmpty = false,
  }) {
    if (password.isEmpty) {
      return 'validator_error_empty_password';
    }

    final isValid = canSubmitPassword(
      password: password,
      minLength: minLength,
      validateJustEmpty: validateJustEmpty,
    );

    if (isValid) {
      return null;
    } else {
      return 'validator_error_invalid_password';
    }
  }
}
