import 'package:collection/collection.dart';

enum AppRole { user, viewer, editor, admin }

extension AppRolesFromString on String? {
  AppRole? toAppRole() {
    if (this == null || this?.isEmpty == true) {
      return null;
    }

    return AppRole.values.firstWhereOrNull((item) {
      return item.name == this;
    });
  }
}
