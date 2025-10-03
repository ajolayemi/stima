import 'package:flutter/material.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';

/// Base flutter's [RichText] widget has a default textScaler set to [TextScaler.noScaling]
/// this widget serves as a common workaround to apply a custom [TextScaler]
/// when provided or the globally available one
class ScaledRichText extends StatelessWidget {
  const ScaledRichText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.start,
    this.textScaler,
  });

  final TextAlign textAlign;
  final InlineSpan text;
  final TextScaler? textScaler;

  @override
  Widget build(BuildContext context) {
    final globalTextScale = context.textScale;
    return RichText(
      text: text,
      textAlign: textAlign,
      textScaler: textScaler ?? TextScaler.linear(globalTextScale),
    );
  }
}
