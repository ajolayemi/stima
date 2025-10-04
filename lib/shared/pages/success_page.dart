import 'package:flutter/material.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/success_page_container_icon.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({
    super.key,
    required this.title,
    this.subtitle,
    this.ctaLabel,
    this.onCtaPressed,
    this.hasAppBar = false,
    this.onBackPressed,
  });

  final Widget title;
  final Widget? subtitle;
  final String? ctaLabel;
  final VoidCallback? onCtaPressed;
  final bool hasAppBar;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      hasAppBar: hasAppBar,
      onBackPressed: onBackPressed,
      body: PaddedSafeArea(
        padding: const EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SuccessPageContainerIcon(),
              gapH24,
              title,
              gapH12,
              subtitle ?? const SizedBox.shrink(),
              if (ctaLabel != null) ...[
                gapH24,
                AppPrimaryButton(
                  label: ctaLabel ?? '',
                  onPressed: onCtaPressed,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
