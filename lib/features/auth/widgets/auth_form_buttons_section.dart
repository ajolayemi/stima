import 'package:flutter/material.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';
import 'package:stima/shared/widgets/buttons/app_secondary_button.dart';
import 'package:stima/shared/widgets/buttons/app_text_button.dart';
import 'package:stima/shared/widgets/or_with_widget.dart';
import 'package:stima/shared/widgets/progress/app_circular_loader.dart';

class AuthFormButtonsSection extends StatelessWidget {
  const AuthFormButtonsSection({
    super.key,
    this.isLoading = false,
    this.authButtonEnabled = false,
    this.onForgotPasswordPressed,
    this.onAuthButtonPressed,
    this.onAuthWithGooglePressed,
    this.authCtaKey,
    this.authButtonLabel,
    this.authWithGoogleLabel,
    this.forgotPasswordLabel,
    this.orWithText,
  });

  final bool isLoading;
  final bool authButtonEnabled;
  final String? authButtonLabel;
  final String? authWithGoogleLabel;
  final String? forgotPasswordLabel;
  final String? orWithText;
  final VoidCallback? onForgotPasswordPressed;
  final VoidCallback? onAuthButtonPressed;
  final VoidCallback? onAuthWithGooglePressed;
  final Key? authCtaKey;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const AppCircularLoader()
        : Column(
            children: [
              if (forgotPasswordLabel != null) ...[
                // Forgot password button
                Align(
                  alignment: Alignment.bottomRight,
                  child: AppTextButton(
                    label: forgotPasswordLabel ?? '',
                    onPressed: onForgotPasswordPressed,
                  ),
                ),
              ],

              gapH12,

              if (authButtonLabel != null) ...[
                // Submit button
                AppPrimaryButton(
                  label: authButtonLabel ?? '',
                  onPressed: authButtonEnabled ? onAuthButtonPressed : null,
                  key: authCtaKey,
                ),

                gapH32,
              ],

              if (orWithText != null) ...[
                OrWithWidget(orText: orWithText ?? ''),
                gapH32,
              ],

              if (authWithGoogleLabel != null)
                AppSecondaryButton(
                  label: authWithGoogleLabel ?? '',
                  onPressed: onAuthWithGooglePressed,
                  icon: Assets.icons.google.svg(fit: BoxFit.scaleDown),
                ),
            ],
          );
  }
}
