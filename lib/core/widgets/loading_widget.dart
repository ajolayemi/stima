
import 'package:flutter/material.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class LoadingWidget extends StatelessWidget {
  final bool showText;
  final Color? loaderBackgroundColor;
  final double loaderHeight;
  final double? loaderWidth;

  const LoadingWidget({
    super.key,
    this.showText = true,
    this.loaderBackgroundColor,
    this.loaderHeight = AppSizes.p50,
    this.loaderWidth,
  });

  Widget get loader => CircularProgressIndicator.adaptive(
    backgroundColor: loaderBackgroundColor,
  );

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    final textTheme = context.textTheme;
    return showText
        ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                loader,
                AppSizes.gapH12,
                Text(loc.generic_loading, style: textTheme.bodyMedium),
              ],
            ),
          )
        : SizedBox(
            height: loaderHeight,
            width: loaderWidth,
            child: Center(child: loader),
          );
  }
}