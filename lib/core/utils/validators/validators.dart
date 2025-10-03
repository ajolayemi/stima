import 'package:flutter/services.dart';

/// This file contains some helper functions used for string validation.

abstract class AppValidator {
  bool isValid(String value);
  bool isPartialValid(String value);
}

/// This class is used to validate a string using a regular expression.
class RegexValidator implements AppValidator {
  RegexValidator({required this.regexSource});
  final String regexSource;

  /// Returns true if the value matches the regular expression in its entirety.
  @override
  bool isValid(String value) {
    try {
      // https://regex101.com/
      final RegExp regex = RegExp(regexSource);
      final Iterable<Match> matches = regex.allMatches(value);
      for (final match in matches) {
        if (match.start != -1) {
          return true;
        }
      }
      return false;
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }

  @override
  bool isPartialValid(String value) {
    try {
      // https://regex101.com/
      final RegExp regex = RegExp(regexSource);
      return regex.hasMatch(value);
    } catch (e) {
      // Invalid regex
      assert(false, e.toString());
      return true;
    }
  }
}

class ValidatorInputFormatter implements TextInputFormatter {
  ValidatorInputFormatter({required this.editingValidator});
  final AppValidator editingValidator;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final bool oldValueValid = editingValidator.isValid(oldValue.text);
    final bool newValueValid = editingValidator.isValid(newValue.text);
    if (oldValueValid && !newValueValid) {
      return oldValue;
    }
    return newValue;
  }
}

/// This class is used to validate a string that is not empty.
class NonEmptyEmailValidator extends RegexValidator {
  NonEmptyEmailValidator() : super(regexSource: '^(|\\S)+\$');
}

/// Used to validate a valid email address.
class EmailValidator extends RegexValidator {
  EmailValidator() : super(regexSource: '^\\S+@\\S+\\.\\S+\$');
}

class NonEmptyStringValidator extends AppValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }

  @override
  bool isPartialValid(String value) {
    throw UnimplementedError();
  }
}

class MinLengthStringValidator extends AppValidator {
  MinLengthStringValidator(this.minLength);
  final int minLength;

  @override
  bool isValid(String value) {
    return value.length >= minLength;
  }

  @override
  bool isPartialValid(String value) {
    throw UnimplementedError();
  }
}

class MaxLengthStringValidator extends AppValidator {
  MaxLengthStringValidator(this.maxLength);
  final int maxLength;

  @override
  bool isValid(String value) {
    return value.length <= maxLength;
  }

  @override
  bool isPartialValid(String value) {
    throw UnimplementedError();
  }
}

// Regex to validate that user entered a numeric value
class NumberValidators extends RegexValidator {
  NumberValidators() : super(regexSource: '^[0-9]+\\.?[0-9]*\$');
}

// Regex to validate that a password has at least a capital letter
class PasswordUppercaseValidator extends RegexValidator {
  PasswordUppercaseValidator() : super(regexSource: '[A-Z]');
}

// Regex to validate that a password has at least a lowercase letter
class PasswordLowercaseValidator extends RegexValidator {
  PasswordLowercaseValidator() : super(regexSource: '[a-z]');
}

// Regex to validate that a password has at least a digit
class PasswordDigitValidator extends RegexValidator {
  PasswordDigitValidator() : super(regexSource: '\\d');
}

// Regex to validate that a password has at least a special character
class PasswordSpecialCharValidator extends RegexValidator {
  PasswordSpecialCharValidator()
    : super(regexSource: '[!@#\$%^&*(),.?":{}|<>]');
}
