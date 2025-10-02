import 'package:flutter/material.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class PaddedSafeArea extends StatelessWidget {
  const PaddedSafeArea({
    super.key,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSizes.p8),
    required this.child,
  });

  final EdgeInsets padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
