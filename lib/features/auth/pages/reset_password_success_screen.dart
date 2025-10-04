import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/shared/pages/success_page.dart';

class ResetPasswordSuccessScreen extends ConsumerWidget {
  const ResetPasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return SuccessPage(
      onBackPressed: () => AppUtils.resetPasswordVisibilityProviders(ref),
      title: Text(
        loc.password_reset_success_dialog_title,
        style: textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
      subtitle: Text(
        loc.password_reset_success_dialog_content,
        style: textTheme.bodyMedium?.copyWith(color: AppColors.textPrimary),
        textAlign: TextAlign.center,
      ),
      ctaLabel: loc.password_reset_success_go_to_login,
      onCtaPressed: () {
        AppUtils.resetPasswordVisibilityProviders(ref);
        context.goNamed(AppRoute.login.name);
      },
    );
  }
}
