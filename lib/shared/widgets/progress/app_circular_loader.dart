import 'package:flutter/material.dart';

class AppCircularLoader extends StatelessWidget {
  const AppCircularLoader({super.key, this.bgColor, this.strokeWidth});

  final Color? bgColor;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(
      backgroundColor: bgColor,
      strokeWidth: strokeWidth,
    );
  }
}
