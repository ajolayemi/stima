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
    this.canPop = true,
    this.bottomNavigationBar,
    this.appBarTitle,
    this.hasFAB = false,
    this.onFABPressed,
    this.appBarActionWidgets = const [],
  });

  final Color? bgColor;
  final VoidCallback? onBackPressed;
  final Color? appBarBgColor;
  final bool hasAppBar;
  final Widget? body;
  final bool addGradientBg;
  final Gradient? gradientBg;
  final bool canPop;
  final Widget? bottomNavigationBar;
  final Widget? appBarTitle;
  final bool hasFAB;
  final VoidCallback? onFABPressed;
  final List<Widget> appBarActionWidgets;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
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
                title: appBarTitle,
                actions: appBarActionWidgets,
                leading: !canPop
                    ? null
                    : IconButton(
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
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: hasFAB
            ? FloatingActionButton(
                onPressed: onFABPressed,
                child: Assets.icons.addIconWhite.svg(),
              )
            : null,
      ),
    );
  }
}
