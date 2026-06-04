import 'package:flutter/material.dart';

class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.style,
  });

  final VoidCallback? onPressed;
  final String label;
  final Widget? icon;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      label: Text(label),
      icon: icon,
      style: style,
    );
  }
}
