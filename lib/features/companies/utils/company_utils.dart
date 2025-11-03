import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/core/utils/dialogs/app_alert_dialog_utils.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/companies/providers/company_form_providers.dart';

class CompanyUtils {
  const CompanyUtils._();

  static void resetFormProviderState(WidgetRef ref) {
    ref.invalidate(companyFormDataProvider);
  }

  static Future<void> confirmFormExit({
    required BuildContext context,
    required VoidCallback onConfirmed,
    required WidgetRef ref,
  }) async {
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
        onConfirmed();
        resetFormProviderState(ref);
      },
    );
  }
}
