import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/enums/app_role.dart';
import 'package:stima/core/providers/app_device_info_provider.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_card.dart';
import 'package:stima/shared/widgets/app_circle_avatar.dart';
import 'package:stima/shared/widgets/app_divider.dart';
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
      canPop: AppUtils.pageCanPop(context),
      body: ResponsiveScrollable(
        child: PaddedSafeArea(
          padding: const EdgeInsets.only(
            right: AppSizes.p24,
            left: AppSizes.p24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppSizes.gapH12,
              AppCard(
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.p16),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final user = ref.watch(authStateChangesProvider).value;
                      final hasImgUrl = user?.hasImgUrl == true;

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: AppSizes.p16,
                            children: [
                              Container(
                                width: AppSizes.p100,
                                height: AppSizes.p100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: hasImgUrl ? Colors.transparent : null,
                                  gradient: !hasImgUrl
                                      ? AppColors.profileAvatarGradient
                                      : null,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: !hasImgUrl
                                      ? Colors.transparent
                                      : null,
                                  backgroundImage: hasImgUrl
                                      ? CachedNetworkImageProvider(
                                          user?.imgUrl ?? '',
                                          errorListener: (_) =>
                                              const SizedBox.shrink(),
                                        )
                                      : null,
                                  child: !hasImgUrl
                                      ? Text(user?.getInitials ?? '')
                                      : null,
                                ),
                              ),

                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      user?.displayName ?? '',
                                      style: textTheme.titleLarge,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                  AppSizes.gapH4,
                                  Consumer(
                                    builder: (context, ref, child) {
                                      final userRole = ref
                                          .watch(userRoleProvider)
                                          .value;
                                      return Text(userRole.uiLabel(context));
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          AppSizes.gapH24,
                          const AppDivider(),
                          AppSizes.gapH4,
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: AppCircleAvatar(
                              child: Assets.icons.personBold.svg(
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            title: Text(
                              loc.user_profile_email_label,
                              style: textTheme.bodyLarge?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            subtitle: Text(
                              user?.email ?? '',
                              style: textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              AppSizes.gapH12,

              Text(
                loc.user_profile_account_section_title,
                style: textTheme.bodyLarge,
              ),
              AppSizes.gapH12,
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

              AppSizes.gapH12,
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
              AppSizes.gapH32,
              const AppDivider(),
              AppSizes.gapH8,
              Center(
                child: Consumer(
                  builder: (context, ref, child) {
                    final appVersion = ref
                        .watch(appDeviceInfoProvider)
                        .value
                        ?.versionStringForUi;

                    return Text(
                      loc.user_profile_app_version_info_label(appVersion ?? ''),
                    );
                  },
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
