import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class FormStepperIndicator extends StatelessWidget {
  const FormStepperIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  final int totalSteps;

  /// Current step are to be expressed from 1
  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final screenWidth = context.screenWidth;
    final textTheme = context.textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          loc.form_stepper_indicator_label(currentStep, totalSteps),
          style: textTheme.bodyMedium,
        ),
        AppSizes.gapH8,
        Container(
          height: 12,
          width: screenWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: AppColors.gray200.withValues(alpha: 0.4),
          ),
          child: FractionallySizedBox(
            alignment: AlignmentDirectional.topStart,
            widthFactor: currentStep / totalSteps,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.green600.withValues(alpha: 0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
