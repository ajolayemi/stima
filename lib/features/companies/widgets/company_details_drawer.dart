import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/core/utils/url_launcher_utils.dart';
import 'package:stima/core/widgets/async_value_widget.dart';
import 'package:stima/core/widgets/base_drawer_container.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/features/companies/controller/company_details_controller.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';

class CompanyDetailsDrawer extends ConsumerWidget {
  const CompanyDetailsDrawer({super.key, this.companyId});

  final String? companyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    final asyncValue = ref.watch(
      companyDetailsControllerProvider(companyId ?? ''),
    );
    return AsyncValueWidget(
      asyncValue: asyncValue,
      onData: (data) {
        final details = data?.details;

        if (details == null) {
          return const SizedBox.shrink();
        }

        return AppBaseDrawerContainer(
          childPadding: .symmetric(horizontal: AppSizes.p20),
          child: Column(
            crossAxisAlignment: .start,
            spacing: AppSizes.p4,
            children: [
              _HeaderRowItem(
                alternativeWidget: Row(
                  spacing: AppSizes.p20,
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Text(details.name ?? '', style: textTheme.titleLarge),
                    Consumer(
                      builder: (context, ref, child) {
                        final canEdit = ref
                            .watch(userRoleProvider)
                            .value
                            ?.canEdit;
                        return Visibility(
                          visible: canEdit == true,
                          child: Row(
                            mainAxisSize: .min,
                            children: [
                              IconButton(
                                padding: .zero,
                                onPressed: () {},
                                icon: Assets.icons.modify.svg(),
                                tooltip:
                                    loc.company_details_modify_button_tooltip,
                              ),
                              IconButton(
                                padding: .zero,
                                onPressed: () {},
                                icon: Assets.icons.delete.svg(),
                                tooltip:
                                    loc.company_details_delete_button_tooltip,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              _HeaderRowItem(
                label: details.address,
                style: textTheme.bodyMedium,
              ),

              _DetailsRowItem(
                content: details.contactPersonName,
                leadingIcon: Assets.icons.person.svg(),
              ),

              _DetailsRowItem(
                content: details.phoneNumber,
                leadingIcon: Assets.icons.phone.svg(),
                onTap: () {
                  UrlLauncherUtils.launchTelUtil(details.phoneNumber);
                },
              ),
              _DetailsRowItem(
                content: details.email,
                leadingIcon: Assets.icons.email.svg(),
              ),
              AppSizes.gapH12,
              Visibility(
                visible: details.hasKmlFileLink == true,
                child: AppPrimaryButton(
                  label: loc.companies_list_item_view_on_map_btn,
                  onPressed: () {
                    // TODO: add redirection to map page
                  },
                ),
              ),
              AppSizes.gapH24,
            ],
          ),
        );
      },
      onErrorRetry: () {
        ref.invalidate(companyDetailsControllerProvider(companyId ?? ''));
      },
    );
  }
}

class _HeaderRowItem extends StatelessWidget {
  const _HeaderRowItem({this.label, this.style, this.alternativeWidget});

  final String? label;
  final TextStyle? style;
  final Widget? alternativeWidget;

  @override
  Widget build(BuildContext context) {
    return alternativeWidget ??
        Visibility(
          visible: label?.isNotEmpty == true,
          child: Text(label ?? '', style: style),
        );
  }
}

class _DetailsRowItem extends StatelessWidget {
  const _DetailsRowItem({this.content, this.leadingIcon, this.onTap});

  final String? content;
  final Widget? leadingIcon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Visibility(
      visible: content?.isNotEmpty == true,
      child: ListTile(
        contentPadding: .zero,
        horizontalTitleGap: AppSizes.p4,
        minLeadingWidth: AppSizes.p24,
        minTileHeight: AppSizes.p12,
        isThreeLine: false,
        internalAddSemanticForOnTap: false,
        title: Text(content ?? '', style: textTheme.bodyLarge),
        leading: leadingIcon,
        onTap: onTap,
      ),
    );
  }
}
