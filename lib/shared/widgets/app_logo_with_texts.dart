import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class AppLogoWithTexts extends StatelessWidget {
  const AppLogoWithTexts({super.key, this.title, this.subtitle});

  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.icons.appIcon.svg(),
          if (title != null) ...[
            AppSizes.gapH12,
            Text(title!, style: textTheme.titleLarge),
          ],
          if (subtitle != null) ...[
            AppSizes.gapH4,
            Text(
              subtitle!,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.gray600),
            ),
          ],
        ],
      ),
    );
  }
}
