import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/features/startup/providers/app_startup_provider.dart';
import 'package:stima/features/startup/widgets/app_startup_error_widget.dart';
import 'package:stima/features/startup/widgets/app_startup_loading_widget.dart';

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({
    super.key,
    required this.onLoaded,
  });

  // Main widget to return after startup logic has been loaded
  final Widget onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
        data: (_) => onLoaded,
        error: (e, st) => AppStartupErrorWidget(
              message: e.toString(),
              onRetry: () => ref.invalidate(appStartupProvider),
            ),
        loading: () => const AppStartupLoadingWidget());
  }
}