import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/companies/controller/add_company_controller.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_circle_avatar.dart';

class CompanyFileUploaderWidget extends ConsumerWidget {
  const CompanyFileUploaderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return GestureDetector(
      onTap: ref.read(addCompanyControllerProvider.notifier).pickKmlFile,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(AppSizes.p8),
          dashPattern: const [6, 3],
          color: AppColors.gray400,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.p24,
            horizontal: AppSizes.p12,
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: AppSizes.p24,
              children: [
                AppCircleAvatar(
                  child: Assets.icons.upload.svg(fit: BoxFit.scaleDown),
                ),
                Text(
                  loc.add_new_company_step_two_upload_btn,
                  style: textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
