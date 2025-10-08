import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_card.dart';

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
    this.elevation,
  });

  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Color? color;
  final double? elevation;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AppCard(
        color: color ?? AppColors.white,
        elevation: elevation,
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
