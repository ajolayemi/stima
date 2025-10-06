import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/core/controller/app_link_controller.dart';
import 'package:stima/core/providers/firebase_providers.dart';
import 'package:stima/features/startup/pages/app_splash_screen.dart';
import 'package:stima/features/startup/pages/force_update_screen.dart';
import 'package:stima/features/startup/providers/app_startup_provider.dart';
import 'package:stima/features/startup/widgets/app_startup_error_widget.dart';

class AppStartupWidget extends ConsumerStatefulWidget {
  const AppStartupWidget({super.key, required this.onLoaded});

  // Main widget to return after startup logic has been loaded
  final Widget onLoaded;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppStartupWidgetState();
}

class _AppStartupWidgetState extends ConsumerState<AppStartupWidget> {
  @override
  void initState() {
    ref.read(firebaseRemoteConfigStreamProvider);
    ref.read(appLinkControllerProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      data: (data) {
        if (data.updateRequired) {
          return ForceUpdateScreen(androidPackageName: data.androidPackageName);
        }
        return widget.onLoaded;
      },
      error: (e, st) => AppStartupErrorWidget(
        message: e.toString(),
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
      loading: () => const AppSplashScreen(),
    );
  }
}
