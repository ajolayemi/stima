import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/url_launcher_utils.dart';
import 'package:stima/features/companies/models/company.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_divider.dart';

class CompaniesListItem extends ConsumerWidget {
  const CompaniesListItem({super.key, this.company});

  final Company? company;

  bool get _hasPhoneNumber {
    return company?.hasPhoneNumber == true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;

    if (company == null) {
      return const SizedBox.shrink();
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.p16),
        border: Border.all(color: AppColors.gray200, width: 1),
      ),
      child: Column(
        // spacing: AppSizes.p8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.p16,
              right: AppSizes.p16,
              top: AppSizes.p16,
            ),
            child: Column(
              // spacing: AppSizes.p8,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  isThreeLine: false,
                  horizontalTitleGap: AppSizes.p4,
                  minLeadingWidth: AppSizes.p24,
                  minTileHeight: AppSizes.p12,
                  title: Text(
                    company?.name ?? '',
                    style: textTheme.bodyLarge?.copyWith(),
                  ),
                  trailing: Assets.icons.arrowRight.svg(fit: BoxFit.contain),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: AppSizes.p4,
                  minLeadingWidth: AppSizes.p24,
                  minTileHeight: AppSizes.p12,
                  isThreeLine: false,
                  internalAddSemanticForOnTap: false,
                  leading: Assets.icons.person.svg(fit: BoxFit.contain),
                  minVerticalPadding: 0,
                  title: Text(
                    company?.contactPersonName ?? '',
                    style: textTheme.bodyMedium,
                  ),
                ),

                Visibility(
                  visible: _hasPhoneNumber,
                  child: TextButton.icon(
                    onPressed: () {
                      UrlLauncherUtils.launchTelUtil(company?.phoneNumber);
                    },
                    iconAlignment: IconAlignment.start,
                    label: Text(
                      company?.phoneNumber ?? '',
                      style: textTheme.bodyMedium?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    icon: Assets.icons.phone.svg(fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),
          AppDivider(thickness: 2),
          Center(
            child: TextButton.icon(
              // TODO: implement onPressed
              onPressed: () {},
              label: Text(
                loc.companies_list_item_view_on_map_btn,
                style: textTheme.bodyMedium,
              ),
              icon: Assets.icons.map.svg(
                fit: BoxFit.contain,
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
