import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:app_links/app_links.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/config/routes/router.dart';
import 'package:stima/core/models/path_parameters.dart';
import 'package:stima/features/startup/providers/app_startup_provider.dart';
part 'app_link_controller.g.dart';

@Riverpod(keepAlive: true)
class AppLinkController extends _$AppLinkController {
  StreamSubscription<Uri>? _subscription;

  GoRouter get _router => ref.read(goRouterProvider);
  @override
  FutureOr<void> build() async {
    final appInitResult = await ref.watch(appStartupProvider.future);

    if (!appInitResult.startupCompleted || appInitResult.updateRequired) {
      return;
    }
    _subscription = AppLinks().uriLinkStream.listen((uri) {
      debugPrint('Received URI: $uri');
      final path = uri.path;
      final queryParams = uri.queryParameters;
      if (path == '/__/auth/links') {
        final link = queryParams['link'];
        if (link == null || link.isEmpty) {
          return;
        } else {
          final parsedLink = Uri.parse(link);
          final parsedLinkQueryParams = parsedLink.queryParameters;
          final oobCode = parsedLinkQueryParams['oobCode']?.toString();
          final mode = parsedLinkQueryParams['mode']?.toString();
          final continueUrl = parsedLinkQueryParams['continueUrl']?.toString();

          if (oobCode != null && mode != null && continueUrl != null) {
            if (mode == 'resetPassword') {
              _processPasswordResetLink(continueUrl, oobCode);
            }
          }
        }
      }
    });

    ref.onDispose(() {
      _subscription?.cancel();
    });
    return null;
  }

  void _processPasswordResetLink(String link, String verificationCode) {
    final parsedLink = Uri.parse(link);
    final parsedLinkPath = parsedLink.path;
    if (parsedLinkPath == '/verify') {
      _router.goNamed(
        AppRoute.resetPassword.name,
        pathParameters: PathParameters(
          passwordResetConfirmationCode: verificationCode,
        ).toJson(),
      );
    }
  }
}
