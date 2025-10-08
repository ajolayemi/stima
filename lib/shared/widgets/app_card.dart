import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.elevation,
    this.margin,
  });

  final Widget child;
  final Color? color;
  final double? elevation;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(elevation: elevation, margin: margin, child: child),
    );
  }
}
