import 'package:flutter/material.dart';

class AppKeyboardUtils {
  const AppKeyboardUtils._();

  static void hideKeyboard() {
    final hasFocus = FocusManager.instance.primaryFocus?.hasFocus ?? false;
    if (hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
