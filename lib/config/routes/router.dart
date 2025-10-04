import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/config/routes/go_router_refresh_stream.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/routes/router_redirect_service.dart';
import 'package:stima/core/utils/extensions/router_extensions.dart';
import 'package:stima/features/auth/pages/forgot_password_success_screen.dart';
import 'package:stima/features/auth/pages/forgot_password_screen.dart';
import 'package:stima/features/auth/pages/login_screen.dart';
import 'package:stima/features/auth/pages/registration_screen.dart';
import 'package:stima/features/auth/pages/reset_password_screen.dart';
import 'package:stima/features/auth/pages/reset_password_success_screen.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';
import 'package:stima/features/home/pages/home_page.dart';
import 'package:stima/features/startup/widgets/app_startup_loading_widget.dart';

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
        path: AppRoute.startup.path,
        name: AppRoute.startup.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: AppStartupLoadingWidget(),
            fullscreenDialog: true,
          );
        },
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        pageBuilder: (context, state) {
          return MaterialPage(child: LoginScreen(), fullscreenDialog: true);
        },
        routes: [
          // Forgot password screen (where user is asked to enter there email address)
          GoRoute(
            path: AppRoute.forgotPassword.path,
            name: AppRoute.forgotPassword.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                child: ForgotPasswordScreen(),
                fullscreenDialog: true,
              );
            },
            routes: [
              // The screen displayed after the mail
              GoRoute(
                path: AppRoute.forgotPasswordSuccess.path,
                name: AppRoute.forgotPasswordSuccess.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: ForgotPasswordSuccessScreen(
                      email: state.emailFromPath,
                    ),
                    fullscreenDialog: true,
                  );
                },
              ),
            ],
          ),

          // Password reset screen (where user can enter the new desired password)
          GoRoute(
            path: AppRoute.resetPassword.path,
            name: AppRoute.resetPassword.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                child: ResetPasswordScreen(
                  confirmationCode: state.codeFromPath,
                ),
                fullscreenDialog: true,
              );
            },
            routes: [
              // The screen displayed after password reset is complete
              GoRoute(
                path: AppRoute.resetPasswordSuccess.path,
                name: AppRoute.resetPasswordSuccess.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: ResetPasswordSuccessScreen(),
                    fullscreenDialog: true,
                  );
                },
              ),
            ],
          ),
        ],
      ),

      // The page to sign up
      GoRoute(
        path: AppRoute.register.path,
        name: AppRoute.register.name,
        pageBuilder: (context, state) {
          return MaterialPage(
            child: RegistrationScreen(),
            fullscreenDialog: true,
          );
        },
      ),

      // The app home page
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        pageBuilder: (context, state) {
          return MaterialPage(child: HomePage(), fullscreenDialog: true);
        },
      ),
    ],
  );
}
