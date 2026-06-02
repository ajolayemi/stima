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
import 'package:stima/features/companies/pages/companies_list_page.dart';
import 'package:stima/features/draft_survey/pages/draft_survey_page.dart';
import 'package:stima/features/home/pages/home_page.dart';
import 'package:stima/features/main/widgets/app_navigation_bar.dart';
import 'package:stima/features/profile/pages/profile_page.dart';
import 'package:stima/features/startup/pages/app_splash_screen.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'HomePage',
);
final _draftsShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Draft surveys',
);

final _companyShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'Companies list',
);
final _profileShellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'ProfilePage',
);

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  final redirectService = ref.watch(routerRedirectServiceProvider);
  final authRepo = ref.watch(authRepositoryProvider);
  return GoRouter(
    initialLocation: AppRoute.splashScreen.path,
    // debugLogDiagnostics: kDebugMode,
    // redirect logic based on auth state
    redirect: redirectService.redirect,
    navigatorKey: _rootNavigatorKey,
    refreshListenable: GoRouterRefreshStream(authRepo.authStateChanges()),
    routes: [
      GoRoute(
        path: AppRoute.splashScreen.path,
        name: AppRoute.splashScreen.name,
        pageBuilder: (context, state) {
          return MaterialPage(child: AppSplashScreen(), fullscreenDialog: true);
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

      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        branches: [
          // The app home page
          StatefulShellBranch(
            navigatorKey: _homeShellNavigatorKey,
            routes: [
              // The app home page
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: HomePage(),
                    fullscreenDialog: true,
                  );
                },
              ),
            ],
          ),

          // The draft surveys page
          StatefulShellBranch(
            navigatorKey: _draftsShellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.draftSurvey.path,
                name: AppRoute.draftSurvey.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: DraftSurveyPage(),
                    fullscreenDialog: true,
                  );
                },
              ),
            ],
          ),

          // The companies list page
          StatefulShellBranch(
            navigatorKey: _companyShellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.companies.path,
                name: AppRoute.companies.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: CompaniesListPage(),
                    fullscreenDialog: true,
                  );
                },
              ),
            ],
          ),

          // The user profile page
          StatefulShellBranch(
            navigatorKey: _profileShellNavigatorKey,
            routes: [
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    child: ProfilePage(),
                    fullscreenDialog: true,
                  );
                },
              ),
            ],
          ),
        ],
        builder: (context, state, navigationShell) {
          return AppNavigationBar(navigationShell: navigationShell);
        },
      ),
    ],
  );
}
