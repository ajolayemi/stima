import 'package:flutter/material.dart';
import 'package:stima/gen/assets.gen.dart';

class VisibilityIconButton extends StatelessWidget {
  const VisibilityIconButton({
    super.key,
    this.onPressed,
    this.isVisible = false,
  });

  final VoidCallback? onPressed;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: isVisible
          ? Assets.icons.visibilityOff.svg()
          : Assets.icons.visibilityOn.svg(),
    );
  }
}
