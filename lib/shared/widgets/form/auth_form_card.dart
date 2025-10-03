import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class AuthFormCard extends StatelessWidget {
  const AuthFormCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth,
      padding: EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(AppSizes.p24)),
      ),
      child: child,
    );
  }
}
