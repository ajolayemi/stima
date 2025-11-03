import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:stima/core/utils/extensions/context_extensions.dart';

enum AppRole {
  /// The most basic role, those with this role are allowed to login to the app
  /// but without being able to view it's content
  viewer(canView: false, canEdit: false),

  /// Those with this role are allowed to do all that the [viewer] is allowed to do and
  /// view the app's contents. They aren't allow to update the app's contents such as add new surveys,
  /// update existing ones and so on
  user(canView: true, canEdit: false),

  /// Those with this role are allowed to do what both [user] and [viewer] can do and can update / add
  /// contents such as new survey, update existing survey and so on
  editor(canView: true, canEdit: true),

  /// The upmost role with the possibility of doing what [user], [viewer] and [editor] can do.
  /// They're also able to:
  /// 1. Add new users
  /// 2. Update existing user role
  admin(canView: true, canEdit: true);

  final bool canEdit;
  final bool canView;

  const AppRole({this.canEdit = false, this.canView = false});
}

extension AppRolesFromString on String? {
  AppRole toAppRole() {
    if (this == null || this?.isEmpty == true) {
      return AppRole.viewer;
    }

    return AppRole.values.firstWhereOrNull((item) {
          return item.name == this;
        }) ??
        AppRole.viewer;
  }
}

extension AppRoleToString on AppRole? {
  String? toStr() {
    return this?.name;
  }

  String uiLabel(BuildContext context) {
    final loc = context.loc;

    if (this == null) {
      return '';
    }

    switch (this!) {
      case AppRole.user:
        return loc.app_role_user;
      case AppRole.viewer:
        return loc.app_role_viewer;
      case AppRole.editor:
        return loc.app_role_editor;
      case AppRole.admin:
        return loc.app_role_admin;
    }
  }
}
