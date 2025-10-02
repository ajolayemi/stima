import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/config/routes/go_router_refresh_stream.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/routes/router_redirect_service.dart';
import 'package:stima/features/auth/pages/login_screen.dart';
import 'package:stima/features/auth/pages/signup_screen.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final redirectService = ref.watch(routerRedirectServiceProvider);
  final authRepo = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: AppRoute.login.path,
    debugLogDiagnostics: kDebugMode,
    // redirect logic based on auth state
    redirect: redirectService.redirect,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(authRepo.authStateChanges()),
    routes: [
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginScreen(), fullscreenDialog: true);
        },
      ),
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        pageBuilder: (context, state) {
          return MaterialPage(child: SignupScreen(), fullscreenDialog: true);
        },
      ),
    ],
  );
}
