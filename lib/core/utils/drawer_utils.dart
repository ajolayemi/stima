import 'package:flutter/material.dart';
import 'package:stima/shared/constants/app_sizes.dart';

class DrawerUtils {
  const DrawerUtils._();

  static Future<T?> showAppModalBottomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isScrollControlled = true,
    bool isDismissible = true,
    bool useSafeArea = true,
    bool useRootNavigator = true,
  }) async {
    return await showModalBottomSheet<T>(
      isScrollControlled: true,
      isDismissible: isDismissible,
      context: context,
      useSafeArea: useSafeArea,
      useRootNavigator: useRootNavigator,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.vertical(
          top: Radius.circular(AppSizes.p16),
        ),
      ),
      builder: builder,
    );
  }
}
