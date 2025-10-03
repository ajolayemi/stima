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
        return UserNotFoundException(stackTrace: st);
      case 'email-already-in-use':
        return EmailAlreadyInUseException(stackTrace: st);
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
    }

    return loc.error_dialog_generic_content;
  }
}
