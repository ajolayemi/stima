import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/texts/scaled_rich_text.dart';

class ForgotPasswordMailSentScreen extends StatelessWidget {
  const ForgotPasswordMailSentScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return AppScaffold(
      hasAppBar: true,
      body: PaddedSafeArea(
        padding: const EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                loc.forgot_password_email_sent_page_title,
                style: textTheme.titleLarge,
              ),
              gapH12,
              ScaledRichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: loc.forgot_password_email_sent_page_subtitle_first,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),

                  children: [
                    TextSpan(
                      text: AppUtils.obfuscateEmail(email),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: '.\n${loc.forgot_password_email_sent_page_subtitle_second}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              gapH24,
              AppPrimaryButton(
                label: loc.forgot_password_email_sent_page_cta_btn,
                onPressed: () {
                  // context.re
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
