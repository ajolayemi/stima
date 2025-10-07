import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/providers/app_device_info_provider.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_circle_avatar.dart';
import 'package:stima/shared/widgets/app_list_tile.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return AppScaffold(
      hasAppBar: true,
      appBarTitle: Text(loc.user_profile_page_title),
      body: ResponsiveScrollable(
        child: PaddedSafeArea(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.p24,
            vertical: AppSizes.p24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              gapH24,
              Text('User info card goes here'),
              SizedBox(height: 200),
              gapH12,

              AppListTile(
                leading: AppCircleAvatar(
                  child: Assets.icons.settings.svg(fit: BoxFit.scaleDown),
                ),
                trailing: Assets.icons.arrowRight.svg(fit: BoxFit.scaleDown),
                title: Text(
                  loc.user_profile_settings_menu_title,
                  style: textTheme.bodyLarge,
                ),
                onTap: () {
                  print('Settings pressed');
                },
              ),
              gapH12,
              AppListTile(
                leading: AppCircleAvatar(
                  color: AppColors.red50,
                  child: Assets.icons.logout.svg(fit: BoxFit.scaleDown),
                ),
                trailing: Assets.icons.arrowRightRed.svg(fit: BoxFit.scaleDown),
                title: Text(
                  loc.user_profile_logout_menu_title,
                  style: textTheme.bodyLarge?.copyWith(color: AppColors.red800),
                ),
                onTap: () {
                  ref.read(authRepositoryProvider).logOut();
                },
              ),
              gapH12,
              Divider(color: AppColors.gray200),
              Consumer(
                builder: (context, ref, child) {
                  final appVersion = ref
                      .watch(appDeviceInfoProvider)
                      .value
                      ?.versionStringForUi;

                  return Text(loc.user_profile_app_version_info_label(appVersion ?? ''));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
