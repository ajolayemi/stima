import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stima/core/exceptions/app_exception.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';

extension FirebaseAuthExceptionsExtension on FirebaseAuthException {
  AppException? toAppException(StackTrace? st) {
    switch (code) {
      case 'user-not-found':
      case 'user-disabled':
      case 'wrong-password':
      case 'invalid-credential':
        return UserNotFoundException(stackTrace: st);
      case 'email-already-in-use':
        return EmailAlreadyInUseException(stackTrace: st);
      case 'expired-action-code':
      case 'invalid-action-code':
        return ResetPasswordCodeExpiredException(stackTrace: st);
      default:
        return null;
    }
  }
}

extension GoogleAuthExceptionsExtension on GoogleSignInException {
  AppException? toAppException(StackTrace st) {
    switch (code) {
      case GoogleSignInExceptionCode.canceled:
        return SilentException(stackTrace: st);

      default:
        return GenericException(stackTrace: st);
    }
  }
}

extension ExceptionsExt on AppException {
  /// Meant to be used where [BuildContext] is available to retrieve
  /// the title to be shown when displaying error dialog
  String getDialogTitle(BuildContext context) {
    final loc = context.loc;
    return loc.error_dialog_title;
  }

  /// Meant to be used where [BuildContext] is available to retrieve
  /// the title to be shown when displaying error dialog
  String getDialogContent(BuildContext context) {
    final loc = context.loc;
    if (this is UserNotFoundException) {
      return loc.error_dialog_user_not_found_content;
    } else if (this is EmailAlreadyInUseException) {
      return loc.error_dialog_email_already_in_use;
    } else if (this is ResetPasswordCodeExpiredException) {
      return loc.forgot_password_confirmation_code_invalid_error_text;
    } else if (this is NetworkException) {
      final exception = this as NetworkException;
      if (exception.statusCode == 403) {
        return loc.error_dialog_network_403_content;
      }
      return loc.error_dialog_generic_content;
    } else if (this is InvalidKmlFileException) {
      return loc.error_dialog_invalid_company_kml_file;
    }

    return loc.error_dialog_generic_content;
  }

  String? getDialogCloseButtonLabel(BuildContext context) {
    final loc = context.loc;

    if (this is ResetPasswordCodeExpiredException) {
      return loc.forgot_password_confirmation_code_invalid_error_close_btn;
    }
    return null;
  }

  String getDialogMainCtaLabel(BuildContext context) {
    final loc = context.loc;

    if (this is ResetPasswordCodeExpiredException) {
      return loc.forgot_password_confirmation_code_invalid_error_request_cta;
    }
    return loc.error_dialog_ok_cta_btn;
  }
}
