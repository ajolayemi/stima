import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class AppCircleAvatar extends StatelessWidget {
  const AppCircleAvatar({
    super.key,
    this.width,
    this.height,
    this.child,
    this.color,
  });

  final double? width;
  final double? height;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppSizes.p50,
      height: height ?? AppSizes.p50,
      decoration: BoxDecoration(
        color: color ?? AppColors.gray200,
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
