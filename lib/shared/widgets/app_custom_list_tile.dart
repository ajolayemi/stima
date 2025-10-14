import 'package:flutter/material.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class AppCustomListTile extends StatelessWidget {
  const AppCustomListTile({
    super.key,
    this.bgColor,
    this.borderRadius,
    this.contentsPadding,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
  });

  final Color? bgColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? contentsPadding;
  final Widget? leading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(AppSizes.p16),
      ),
      child: Padding(
        padding: contentsPadding ?? const EdgeInsets.all(AppSizes.p16),
        child: Row(
          // mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) ...[
              leading ?? const SizedBox.shrink(),
              gapW12,
            ],
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  title ?? const SizedBox.shrink(),
                  gapH4,
                  subtitle ?? const SizedBox.shrink(),
                ],
              ),
            ),

            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
