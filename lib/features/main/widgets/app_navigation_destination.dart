import 'package:flutter/material.dart';

class AppNavigationDestination extends StatelessWidget {
  const AppNavigationDestination({
    super.key,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.label,
    this.isSelected = false
  });

  final Widget selectedIcon;
  final Widget unselectedIcon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationDestination(
      icon: unselectedIcon,
      selectedIcon: selectedIcon,
      label: label,
    );
  }
}
