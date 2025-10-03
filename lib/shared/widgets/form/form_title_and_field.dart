import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';

class FormTitleAndField extends StatelessWidget {
  const FormTitleAndField({
    super.key,
    required this.fieldKey,
    required this.fieldTitle,
    this.fieldController,
    this.fieldHintText,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.autoCorrect = false,
    this.keyboardType,
    this.keyboardAppearance = Brightness.light,
    this.onEditingComplete,
    this.inputFormatters,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines,
    this.suffixIcon,
    this.onTap,
    this.canRequestFocus = true,
    this.errorText,
    this.maxLength,
    this.prefixIcon,
    this.onChanged,
  });

  final Key fieldKey;
  final String fieldTitle;
  final TextEditingController? fieldController;
  final String? fieldHintText;
  final AutovalidateMode? autovalidateMode;
  final bool autoCorrect;
  final TextInputType? keyboardType;
  final Brightness? keyboardAppearance;
  final VoidCallback? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool obscureText;
  final bool enabled;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool canRequestFocus;
  final String? errorText;
  final int? maxLength;
  final void Function(String value)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        gapH8,
        IgnorePointer(
          ignoring: !enabled,
          child: TextFormField(
            key: fieldKey,
            controller: fieldController,
            onTap: onTap,
            canRequestFocus: canRequestFocus,
            //maxLines: maxLines,
            decoration: InputDecoration(
              hintText: fieldHintText,
              errorMaxLines: 3,
              suffixIcon: suffixIcon,
              errorText: errorText,
              prefixIcon: prefixIcon,
            ),
            autovalidateMode: autovalidateMode,
            validator: validator,
            autocorrect: autoCorrect,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            keyboardAppearance: keyboardAppearance,
            onEditingComplete: onEditingComplete,
            inputFormatters: inputFormatters,
            obscureText: obscureText,
            maxLength: maxLength,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
