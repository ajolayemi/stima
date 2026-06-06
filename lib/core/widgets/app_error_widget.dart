import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';
import 'package:stima/shared/widgets/buttons/app_primary_button.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({
    super.key,
    this.error,
    this.st,
    this.onRetry,
    this.forceShowErrorDetails = false,
    this.showAppBar = false,
  });

  final Object? error;
  final StackTrace? st;
  final VoidCallback? onRetry;
  final bool forceShowErrorDetails;
  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: .dark,
      child: AppScaffold(
      
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              right: AppSizes.p20,
              left: AppSizes.p20,
              top: AppSizes.p24,
            ),
            child: SingleChildScrollView(
              child: Column(
                spacing: AppSizes.p32,
                mainAxisSize: .min,
                children: [
                  Text(
                    loc.error_page_text_content,
                    style: textTheme.bodyMedium,
                    textAlign: .center,
                  ),
                  if (forceShowErrorDetails || kDebugMode)
                    Text(
                      error?.toString() ?? '',
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (onRetry != null)
                    AppPrimaryButton(
                      label: loc.error_page_retry_cta_btn,
                      onPressed: () => onRetry?.call(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}