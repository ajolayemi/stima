import 'package:flutter/material.dart';

class AppCircularLoader extends StatelessWidget {
  const AppCircularLoader({super.key, this.bgColor});

  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive(backgroundColor: bgColor);
  }
}
