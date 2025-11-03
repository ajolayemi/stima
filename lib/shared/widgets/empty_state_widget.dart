import 'package:flutter/material.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, this.icon, this.content, this.cta});

  final Widget? icon;
  final String? content;
  final Widget? cta;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        Visibility(
          visible: icon != null,
          child: icon ?? const SizedBox.shrink(),
        ),
        Visibility(
          visible: content != null,
          child: Text(
            content ?? '',
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),

        Visibility(visible: cta != null, child: cta ?? const SizedBox.shrink()),
      ],
    );
  }
}
