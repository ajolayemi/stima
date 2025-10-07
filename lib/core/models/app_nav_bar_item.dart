import 'package:flutter/material.dart';

class AppNavBarItem {
  final Widget unselectedIcon;
  final Widget selectedIcon;
  final String label;

  AppNavBarItem({
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.label,
  });
}