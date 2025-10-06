import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/core/utils/extensions/router_extensions.dart';

part 'router_redirect_service.g.dart';

/// Service class to handle router redirection logic
class RouterRedirectService {
  const RouterRedirectService(this._ref);
  final Ref _ref;

  AuthRepository get _authRepository => _ref.read(authRepositoryProvider);

  String? redirect(BuildContext context, GoRouterState state) {
    final currentUser = _authRepository.currentUser;

    final currentPath = state.uri.path;

    debugPrint('GoRouterRedirect: current path is $currentPath');

    if (currentUser != null && currentUser.uid.isNotEmpty) {
      // An already logged in user trying to access the login or register page
      // should be directed to home page
      if (currentPath.isLoginOrRegister || currentPath.isSplashScreen) {
        return AppRoute.home.path;
      }
      // No need to redirect, let the user continue to the intended page
      return null;
    }
    // A non-logged in user trying to access a non protected route should be
    // allowed to access it
    if (currentPath.isNotProtectedRoute) {
      return null;
    }

    // No need to redirect, let the user continue to the intended page
    return AppRoute.login.path;
  }
}

@Riverpod(keepAlive: true)
RouterRedirectService routerRedirectService(Ref ref) {
  return RouterRedirectService(ref);
}
