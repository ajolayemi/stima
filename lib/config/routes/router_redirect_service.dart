import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_redirect_service.g.dart';

/// Service class to handle router redirection logic
class RouterRedirectService {
  const RouterRedirectService(this._ref);
  final Ref _ref;

  FutureOr<String?> redirect(BuildContext context, GoRouterState state) async {
    // TODO: [Kehinde] - finish implmentation based on auth state
    return state.uri.path;
  }
}

@Riverpod(keepAlive: true)
RouterRedirectService routerRedirectService(Ref ref) {
  return RouterRedirectService(ref);
}
