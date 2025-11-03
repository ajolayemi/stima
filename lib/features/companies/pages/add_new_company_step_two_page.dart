import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/core/utils/extensions/async_value_extension.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/companies/controller/add_company_controller.dart';
import 'package:stima/features/companies/providers/company_data_providers.dart';
import 'package:stima/features/companies/utils/company_utils.dart';
import 'package:stima/features/companies/widgets/company_file_uploader_widget.dart';
import 'package:stima/features/companies/widgets/company_uploaded_file_widget.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';
import 'package:stima/shared/widgets/form/form_stepper_indicator.dart';
import 'package:stima/shared/widgets/padded_safe_area.dart';
import 'package:stima/shared/widgets/progress/app_loading_overlay_widget.dart';
import 'package:stima/shared/widgets/responsive_widgets/responsive_scrollable_widget.dart';

class AddNewCompanyStepTwoPage extends ConsumerWidget {
  const AddNewCompanyStepTwoPage({super.key});

  void _saveCompany(BuildContext context, WidgetRef ref) async {
    await ref.read(addCompanyControllerProvider.notifier).addCompany();

    if (context.mounted) {
      ref.invalidate(companiesFutureProvider);
      context.goNamed(AppRoute.companies.name);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(addCompanyControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });
    final isLoading = ref.watch(addCompanyControllerProvider).isLoading;
    final textTheme = context.textTheme;
    final loc = context.loc;
    return AppScaffold(
      hasAppBar: true,
      appBarActionWidgets: [
        IconButton(
          onPressed: isLoading
              ? null
              : () {
                  CompanyUtils.confirmFormExit(
                    context: context,
                    ref: ref,
                    onConfirmed: () => context.goNamed(AppRoute.companies.name),
                  );
                },
          icon: Padding(
            padding: const EdgeInsets.only(right: AppSizes.p12),
            child: Assets.icons.close.svg(fit: BoxFit.scaleDown),
          ),
        ),
      ],
      appBarTitle: Text(loc.add_new_company_page_title),
      body: AppLoadingOverlayWidget(
        isLoading: isLoading,
        child: PaddedSafeArea(
          padding: EdgeInsets.only(left: AppSizes.p24, right: AppSizes.p24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ResponsiveScrollable(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapH24,
                      FormStepperIndicator(totalSteps: 2, currentStep: 2),
                      gapH24,
                      Text(
                        loc.add_new_company_step_two_section_title,
                        style: textTheme.titleMedium,
                      ),
                      gapH12,
                      Text(
                        loc.add_new_company_step_two_section_subtitle,
                        style: textTheme.bodyMedium,
                      ),
                      gapH12,
                      CompanyFileUploaderWidget(),
                      gapH12,
                      CompanyUploadedFileWidget(),
                    ],
                  ),
                ),
              ),
              gapH24,
              AppPrimaryButton(
                label: loc.save_cta_button,
                onPressed: isLoading ? null : () => _saveCompany(context, ref),
              ),
              SizedBox(height: context.screenBottomPadding + AppSizes.p16),
            ],
          ),
        ),
      ),
    );
  }
}
