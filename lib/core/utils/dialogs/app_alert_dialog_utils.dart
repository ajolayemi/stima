import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';

class AppAlertDialogUtils {
  const AppAlertDialogUtils._();

  static const kDialogDefaultKey = Key('dialog-default-key');

  /// Generic function to show a platform-aware Material or Cupertino dialog
  static Future<bool?> showAlertDialog({
    required BuildContext context,
    required String title,
    String? content,
    String? cancelActionText,
    String defaultActionText = 'OK',
    VoidCallback? onDefaultActionPressed,
    VoidCallback? onCancelActionPressed,
  }) async {
    return showAdaptiveDialog(
      context: context,
      // * Only make the dialog dismissible if there is a cancel button
      barrierDismissible: cancelActionText != null,
      // * AlertDialog.adaptive was added in Flutter 3.13
      builder: (context) => AlertDialog.adaptive(
        title: Text(title),
        content: content != null ? Text(content) : null,
        // * Use [TextButton] or [CupertinoDialogAction] depending on the platform
        actions: kIsWeb || !Platform.isIOS
            ? <Widget>[
                if (cancelActionText != null)
                  TextButton(
                    child: Text(cancelActionText),
                    onPressed: () {
                      onCancelActionPressed?.call();
                      Navigator.of(context).pop(false);
                    },
                  ),
                TextButton(
                  key: kDialogDefaultKey,
                  child: Text(defaultActionText),
                  onPressed: () {
                    onDefaultActionPressed?.call();
                    Navigator.of(context).pop(true);
                  },
                ),
              ]
            : <Widget>[
                if (cancelActionText != null)
                  CupertinoDialogAction(
                    child: Text(cancelActionText),
                    onPressed: () {
                      onCancelActionPressed?.call();
                      Navigator.of(context).pop(false);
                    },
                  ),
                CupertinoDialogAction(
                  key: kDialogDefaultKey,
                  child: Text(defaultActionText),
                  onPressed: () {
                    onDefaultActionPressed?.call();
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
      ),
    );
  }

  /// Generic function to show a platform-aware Material or Cupertino error dialog
  static Future<void> showExceptionAlertDialog({
    required BuildContext context,
    required String title,
    required String message,
    VoidCallback? onDefaultActionPressed,
    VoidCallback? onCancelActionPressed,
    String? defaultActionText,
    String? cancelActionText,
  }) {
    final loc = context.loc;
    return showAlertDialog(
      context: context,
      title: title,
      content: message,
      defaultActionText: defaultActionText ?? loc.error_dialog_ok_cta_btn,
      cancelActionText: cancelActionText,
      onCancelActionPressed: onCancelActionPressed,
      onDefaultActionPressed: onDefaultActionPressed,
    );
  }

  Future<void> showNotImplementedAlertDialog({required BuildContext context}) {
    return showAlertDialog(context: context, title: 'Not implemented');
  }
}
