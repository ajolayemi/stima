import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(color: color ?? AppColors.gray200);
  }
}
