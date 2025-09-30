import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/l10n/app_localizations.dart';
import 'package:stima/config/routes/go_router_delegate_listener.dart';
import 'package:stima/config/routes/router.dart';
import 'package:stima/config/theme/app_theme.dart';
import 'package:stima/features/startup/widgets/app_startup_widget.dart';

class SurveyApp extends ConsumerWidget {
  const SurveyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: routeConfig,
      debugShowCheckedModeBanner: kDebugMode,
      onGenerateTitle: (context) => 'Stima',
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      theme: AppTheme.getLightTheme(),
      darkTheme: AppTheme.getDarkTheme(),
      builder: (context, child) {
        return AppStartupWidget(
          onLoaded: GoRouterDelegateListener(child: child!),
        );
      },
    );
  }
}
