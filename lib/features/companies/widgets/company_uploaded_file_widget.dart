import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/companies/providers/company_form_providers.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_card.dart';
import 'package:stima/shared/widgets/app_divider.dart';

class CompanyUploadedFileWidget extends ConsumerWidget {
  const CompanyUploadedFileWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    final fileInfo = ref.watch(companyFormFileInfoProvider);
    final fileIsValid = fileInfo?.isValid == true;
    return Visibility(
      visible: fileIsValid,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// File generic info
            ListTile(
              leading: Container(
                width: AppSizes.p50,
                height: AppSizes.p50,
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Assets.icons.file.svg(fit: BoxFit.scaleDown),
              ),
              title: Text(
                fileInfo?.fileName ?? '',
                style: textTheme.bodyLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                fileInfo?.fileSizeString ?? '',
                style: textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                onPressed: () {
                  ref.read(companyFormDataProvider.notifier).resetFileInfo();
                },
                icon: Assets.icons.delete.svg(fit: BoxFit.scaleDown),
              ),
            ),
            AppDivider(),

            Padding(
              padding: const EdgeInsets.all(AppSizes.p16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: AppSizes.p12,
                children: [
                  Text(
                    loc.add_new_company_uploaded_file_data_found_section_title,
                  ),

                  /// Production areas
                  ListTile(
                    tileColor: AppColors.gray100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.p8),
                    ),
                    leading: Container(
                      width: AppSizes.p50,
                      height: AppSizes.p50,
                      decoration: BoxDecoration(
                        color: AppColors.gray200,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Assets.icons.stacchiProduttivi.svg(
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    title: Text(
                      loc.add_new_company_uploaded_file_production_areas_data_title,
                      style: textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      loc.add_new_company_uploaded_file_production_areas_data_subtitle,
                      style: textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      fileInfo?.productionAreasFound.toString() ?? '0',
                      style: textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  /// Access points
                  ListTile(
                    tileColor: AppColors.gray100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.p8),
                    ),
                    leading: Container(
                      width: AppSizes.p50,
                      height: AppSizes.p50,
                      decoration: BoxDecoration(
                        color: AppColors.gray200,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Assets.icons.accessPoint.svg(
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    title: Text(
                      loc.add_new_company_uploaded_file_accesses_data_title,
                      style: textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      loc.add_new_company_uploaded_file_accesses_data_subtitle,
                      style: textTheme.bodyMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Text(
                      fileInfo?.accessAreasFound.toString() ?? '0',
                      style: textTheme.bodyLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            gapH16,
          ],
        ),
      ),
    );
  }
}
