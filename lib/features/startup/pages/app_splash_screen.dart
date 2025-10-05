import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/progress/app_circular_loader.dart';

class AppSplashScreen extends StatelessWidget {
  const AppSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final textTheme = context.textTheme;
    final loc = context.loc;
    return AppScaffold(
      hasAppBar: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: colorScheme.primary,
        child: PaddedSafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.icons.appLogoWhite.svg(fit: BoxFit.scaleDown),
              // gapH8,
              Text(
                loc.app_title,
                style: textTheme.titleMedium?.copyWith(color: AppColors.white),
              ),
              gapH12,
              const AppCircularLoader(bgColor: AppColors.white),
            ],
          ),
        ),
      ),
    );
  }
}
