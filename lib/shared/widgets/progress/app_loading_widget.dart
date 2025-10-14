import 'package:flutter/material.dart';
import 'package:stima/shared/constants/app_sizes.dart';
import 'package:stima/shared/widgets/progress/app_circular_loader.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({
    super.key,
    required this.showText,
    this.loaderColor,
    this.strokeWidth = 4.0,
  });

  final bool showText;
  final Color? loaderColor;
  final double strokeWidth;

  Widget _getLoader() {
    return AppCircularLoader(bgColor: loaderColor, strokeWidth: strokeWidth);
  }

  @override
  Widget build(BuildContext context) {
    return showText
        ? Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_getLoader()],
            ),
        )
        : SizedBox(
            height: AppSizes.p50,
            child: Center(
              child: _getLoader()
            ),
          );
  }
}
