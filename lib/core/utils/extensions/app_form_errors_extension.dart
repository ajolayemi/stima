import 'package:flutter/material.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';

extension AppFormErrorsContextExt on BuildContext {
  String? getLocalizedFormErrorText({
    String? errorKey,
    String? fieldName,
    int? maxFieldLength,
    int? minFieldLength,
  }) {
    if (errorKey == null) return null;

    switch (errorKey) {
      case 'validator_error_empty_email':
        return loc.validator_error_empty_email;
      case 'validator_error_invalid_email':
        return loc.validator_error_invalid_email;
      case 'validator_error_empty_password':
        return loc.validator_error_empty_password;
      case 'validator_error_invalid_password':
        return loc.validator_error_invalid_password(minFieldLength ?? 0);
      case 'validator_generic_error_empty_field':
        return loc.validator_generic_error_empty_field;
      case 'validator_error_passwords_do_not_match':
        return loc.validator_error_passwords_do_not_match;
      default:
        return null;
    }
  }
}
