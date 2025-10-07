import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    this.leading,
    this.trailing,
    this.title,
    this.onTap,
    this.contentPadding,
    this.color,
    this.decoration,
  });

  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Color? color;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:
            decoration ??
            BoxDecoration(
              color: color ?? AppColors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.1),
                  blurRadius: AppSizes.p8,
                ),
              ],
            ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(AppSizes.p16),
          leading: leading,
          trailing: trailing,
          title: title,
        ),
      ),
    );
  }
}
