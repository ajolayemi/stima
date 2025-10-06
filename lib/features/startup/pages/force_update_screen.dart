import 'package:flutter/material.dart';
import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/url_launcher_utils.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_center_widget.dart';

class ForceUpdateScreen extends StatelessWidget {
  const ForceUpdateScreen({super.key, this.androidPackageName});

  final String? androidPackageName;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return AppScaffold(
      hasAppBar: false,
      canPop: false,
      body: PaddedSafeArea(
        padding: const EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
        child: ResponsiveCenter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                loc.force_update_content,
                style: textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              gapH24,
              AppPrimaryButton(
                label: loc.force_update_update_btn,
                onPressed: () {
                  final storeLink = AppUtils.getStoreRedirectUri(
                    androidPackageName: androidPackageName,
                  );
                  UrlLauncherUtils.launchUrlUtil(storeLink);
                },
              ),
            ],    
          ),
        ),
      ),
    );
  }
}
