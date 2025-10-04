import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/shared/pages/success_page.dart';
import 'package:stima/shared/widgets/texts/scaled_rich_text.dart';

class ForgotPasswordSuccessScreen extends ConsumerWidget {
  const ForgotPasswordSuccessScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return SuccessPage(
      onBackPressed: () => AppUtils.resetPasswordVisibilityProviders(ref),
      title: Text(
        loc.forgot_password_email_sent_page_title,
        style: textTheme.titleLarge,
      ),
      subtitle: ScaledRichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: loc.forgot_password_email_sent_page_subtitle_first,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),

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
      ctaLabel: loc.forgot_password_email_sent_page_cta_btn,
      onCtaPressed: () {
        AppUtils.resetPasswordVisibilityProviders(ref);
        context.goNamed(AppRoute.login.name);
      },
    );
  }
}
