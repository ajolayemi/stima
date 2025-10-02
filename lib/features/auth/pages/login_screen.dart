import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/features/auth/widgets/login_form.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';
import 'package:stima/shared/widgets/texts/scaled_rich_text.dart';
import 'package:stima/utils/extensions/context_extensions.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return Scaffold(
      backgroundColor: AppColors.green50,
      // appBar: AppBar(),
      body: PaddedSafeArea(
        padding: EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
        child: ResponsiveScrollable(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: context.screenTopPadding + AppSizes.p24),
              Center(child: Assets.icons.appIcon.svg()),
              gapH12,
              Text(loc.login_screen_icon_text, style: textTheme.titleLarge),
              gapH48,
              const LoginForm(),
              gapH32,
              GestureDetector(
                onTap: () {},
                child: ScaledRichText(
                  text: TextSpan(
                    text: loc.login_screen_no_account,
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.gray600,
                    ),
                    children: [
                      TextSpan(
                        text: ' ${loc.login_screen_sign_up}',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.green600,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.pushNamed(AppRoute.register.name);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              gapH100,
            ],
          ),
        ),
      ),
    );
  }
}
