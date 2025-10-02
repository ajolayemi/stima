import 'package:flutter/widgets.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/utils/extensions/context_extensions.dart';

class OrWithWidget extends StatelessWidget {
  const OrWithWidget({
    super.key,
    required this.orText,
  });

  final String orText;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final dividerColor = AppColors.gray200;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: dividerColor,
          ),
        ),
        gapH8,
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p8,
            vertical: AppSizes.p16,
          ),
          child: Text(
            orText,
            style: textTheme.bodyMedium
          ),
        ),
        gapH8,
        Expanded(
          child: Container(
            height: 1,
            color: dividerColor,
          ),
        ),
      ],
    );
  }
}
