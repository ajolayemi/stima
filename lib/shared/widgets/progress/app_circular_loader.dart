import 'package:flutter/material.dart';

class AppCircularLoader extends StatelessWidget {
  const AppCircularLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator.adaptive();
  }
}
