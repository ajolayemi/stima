import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/core/models/app_nav_bar_item.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';
import 'package:stima/features/main/widgets/app_navigation_destination.dart';
import 'package:stima/gen/assets.gen.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';

/// Bottom navigation bar to show for certain mobile screen sizes
class AppScaffoldWithNavBar extends StatelessWidget {
  const AppScaffoldWithNavBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationChanged,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationChanged;

  List<AppNavBarItem> _getNavBarItems(BuildContext context) {
    final loc = context.loc;
    return [
      AppNavBarItem(
        unselectedIcon: Assets.icons.homeMenuUnselected.svg(),
        selectedIcon: Assets.icons.homeMenuSelected.svg(),
        label: loc.home_page_menu_title,
      ),
      AppNavBarItem(
        unselectedIcon: Assets.icons.draftMenuUnselected.svg(),
        selectedIcon: Assets.icons.draftMenuSelected.svg(),
        label: loc.survey_draft_page_menu_title,
      ),
      AppNavBarItem(
        unselectedIcon: Assets.icons.companyMenuUnselected.svg(),
        selectedIcon: Assets.icons.companyMenuSelected.svg(),
        label: loc.companies_list_page_menu_title,
      ),
      AppNavBarItem(
        unselectedIcon: Assets.icons.profileMenuUnselected.svg(),
        selectedIcon: Assets.icons.profileMenuSelected.svg(),
        label: loc.user_profile_page_menu_title,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationChanged,
        backgroundColor: AppColors.white,
        indicatorColor: Colors.transparent,
        destinations: _getNavBarItems(context).mapIndexed((index, element) {
          return AppNavigationDestination(
            selectedIcon: element.selectedIcon,
            unselectedIcon: element.unselectedIcon,
            label: element.label,
            isSelected: index == selectedIndex,
          );
        }).toList(),
      ),
    );
  }
}
