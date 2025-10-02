import 'package:flutter/material.dart';
import 'package:stima/l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  FocusScopeNode get focusScope => FocusScope.of(this);

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  AppLocalizations get loc => AppLocalizations.of(this);

   double get textScale => MediaQuery.textScalerOf(this).scale(1);
}

extension ScreenExtensions on BuildContext {
  Size get screenSize => MediaQuery.sizeOf(this);

  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  double get screenBottomPadding => screenPadding.bottom;

  double get screenTopPadding => screenPadding.top;
}
