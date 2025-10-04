import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/gen/assets.gen.dart';

class SuccessPageContainerIcon extends StatelessWidget {
  const SuccessPageContainerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppColors.green50,
        shape: BoxShape.circle,
      ),
      child: Assets.icons.confirmMark.svg(fit: BoxFit.scaleDown),
    );
  }
}
