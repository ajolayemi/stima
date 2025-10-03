import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/core/exceptions/app_exception.dart';
import 'package:stima/core/utils/dialogs/app_alert_dialog_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/extensions/exceptions_extension.dart';

extension AsyncValueExtension on AsyncValue {
  /// show an alert dialog if the current [AsyncValue] is an error and the
  /// state isn't loading
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      if (error is SilentException) {
        return;
      }
      AppAlertDialogUtils.showExceptionAlertDialog(
        context: context,
        title: _errorDialogTitle(error, context: context),
        message: _errorDialogMessage(error, context: context),
      );
    }
  }

  String _errorDialogTitle(Object? error, {required BuildContext context}) {
    final loc = context.loc;
    if (error is AppException) {
      return error.getDialogTitle(context);
    }
    return loc.error_dialog_title;
  }

  String _errorDialogMessage(Object? error, {required BuildContext context}) {
    final loc = context.loc;
    if (error is AppException) {
      return error.getDialogContent(context);
    }
    return loc.error_dialog_generic_content;
  }
}
