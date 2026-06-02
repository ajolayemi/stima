import 'package:flutter/material.dart';
import 'package:stima/core/utils/app_utils.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppUtils.title)),
      body: Center(child: Text('Hello ${AppUtils.title}')),
    );
  }
}
