import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/async_value_extension.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/auth/controller/new_password_controller.dart';
import 'package:stima/features/auth/widgets/reset_password_form.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_logo_with_texts.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key, required this.confirmationCode});

  final String confirmationCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(newPasswordControllerProvider, (_, state) {
      state.showAlertDialogOnError(
        context,
        onConfirmActionPressed: () {
          context.goNamed(AppRoute.forgotPassword.name);
          AppUtils.resetPasswordVisibilityProviders(ref);
        },
      );
    });
    final loc = context.loc;
    final isLoading = ref.watch(newPasswordControllerProvider).isLoading;
    return AppScaffold(
      hasAppBar: true,
      addGradientBg: true,
      appBarBgColor: AppColors.green50,
      onBackPressed: () {
        AppUtils.resetPasswordVisibilityProviders(ref);
      },
      body: PaddedSafeArea(
        padding: EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
        child: ResponsiveScrollable(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppSizes.gapH48,
              AppLogoWithTexts(
                title: loc.forgot_password_reset_page_icon_title,
                subtitle: loc.forgot_password_reset_page_icon_subtitle,
              ),
              AppSizes.gapH48,
              ResetPasswordForm(
                isLoading: isLoading,
                confirmationCode: confirmationCode,
              ),
              AppSizes.gapH100,
            ],
          ),
        ),
      ),
    );
  }
}
