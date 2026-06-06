import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/async_value_extension.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/auth/controller/registration_controller.dart';
import 'package:stima/features/auth/widgets/registration_form.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_logo_with_texts.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';
import 'package:stima/shared/widgets/texts/scaled_rich_text.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    ref.listen(registrationControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    final isLoading = ref.watch(registrationControllerProvider).isLoading;

    final textTheme = context.textTheme;
    return AppScaffold(
      addGradientBg: true,
      hasAppBar: true,
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
              AppLogoWithTexts(title: loc.registration_screen_icon_text),
              AppSizes.gapH48,
              RegistrationForm(isLoading: isLoading),
              AppSizes.gapH32,
              ScaledRichText(
                text: TextSpan(
                  text: loc.registration_page_already_have_account,
                  style: textTheme.bodyMedium?.copyWith(
                    color: AppColors.gray600,
                  ),
                  children: [
                    TextSpan(
                      text: ' ${loc.registration_page_login_btn}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.green600,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (isLoading) {
                            return;
                          }
                          context.pop();
                        },
                    ),
                  ],
                ),
              ),
              AppSizes.gapH100,
            ],
          ),
        ),
      ),
    );
  }
}
