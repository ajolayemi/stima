import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stima/features/main/widgets/app_scaffold_with_nav_bar.dart';

// Check the following links for more details on house this type of navigation works:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
// https://codewithandrea.com/articles/flutter-bottom-navigation-bar-nested-routes-gorouter/
class AppNavigationBar extends StatelessWidget {
  AppNavigationBar({Key? key, required this.navigationShell})
    : super(key: key ?? ValueKey<String>('app_navigation_bar'));

  final StatefulNavigationShell navigationShell;

  void _onDestinationChanged(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffoldWithNavBar(
      body: navigationShell,
      selectedIndex: navigationShell.currentIndex,
      onDestinationChanged: _onDestinationChanged,
    );
  }
}
