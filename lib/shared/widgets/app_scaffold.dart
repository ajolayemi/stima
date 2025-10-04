import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/gen/assets.gen.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    this.appBarBgColor,
    this.bgColor,
    this.onBackPressed,
    this.hasAppBar = false,
    this.body,
    this.addGradientBg = false,
    this.gradientBg,
  });

  final Color? bgColor;
  final VoidCallback? onBackPressed;
  final Color? appBarBgColor;
  final bool hasAppBar;
  final Widget? body;
  final bool addGradientBg;
  final Gradient? gradientBg;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop && !hasAppBar) {
          onBackPressed?.call();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: !hasAppBar
            ? null
            : AppBar(
                backgroundColor: appBarBgColor,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  onPressed: () {
                    onBackPressed?.call();
                    context.pop();
                  },
                  icon: Assets.icons.back.svg(),
                ),
              ),
        body: Container(
          decoration: addGradientBg
              ? BoxDecoration(
                  gradient: gradientBg ?? AppColors.linearScaffoldGradient,
                )
              : null,
          child: body,
        ),
      ),
    );
  }
}
