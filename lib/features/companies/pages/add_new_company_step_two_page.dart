import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/core/utils/dialogs/app_alert_dialog_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/companies/controller/add_company_controller.dart';
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

  Future<void> _closePage(BuildContext context) async {
    final loc = context.loc;
    // Ask for confirmation before closing the page
    await AppAlertDialogUtils.showAlertDialog(
      context: context,
      title: loc.add_new_company_form_cancel_dialog_confirmation_title,
      content: loc.add_new_company_form_cancel_dialog_confirmation_content,
      cancelActionLabel:
          loc.add_new_company_form_cancel_dialog_confirmation_cancel_btn,
      confirmActionLabel:
          loc.add_new_company_form_cancel_dialog_confirmation_confirm_btn,
      onDefaultActionPressed: () {
        context.goNamed(AppRoute.companies.name);
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(addCompanyControllerProvider).isLoading;
    final textTheme = context.textTheme;
    final loc = context.loc;
    return AppScaffold(
      hasAppBar: true,
      appBarActionWidgets: [
        GestureDetector(
          onTap: isLoading
              ? null
              : () {
                  _closePage(context);
                },
          child: Padding(
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
                onPressed: isLoading ? null : () {},
              ),
              SizedBox(height: context.screenBottomPadding + AppSizes.p16),
            ],
          ),
        ),
      ),
    );
  }
}
