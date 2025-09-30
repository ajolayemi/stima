import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/config/routes/router.dart';

/// Listener widget to track screen views. Copied from:
/// https://github.com/bizz84/starter_architecture_flutter_firebase/blob/master/lib/src/routing/go_router_delegate_listener.dart
class GoRouterDelegateListener extends ConsumerStatefulWidget {
  const GoRouterDelegateListener({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GoRouterDelegateListenerState();
}

class _GoRouterDelegateListenerState
    extends ConsumerState<GoRouterDelegateListener> {
  /// Helper variable for retrieving the GoRouter delegate
  /// Note: using GoRouter.of(context) throws an exception so we use the goRouterProvider instead
  late final routerDelegate = ref.read(goRouterProvider).routerDelegate;

  @override
  void initState() {
    super.initState();
    routerDelegate.addListener(_listener);
  }

  @override
  void dispose() {
    routerDelegate.removeListener(_listener);
    super.dispose();
  }

  void _listener() {
    // final config = routerDelegate.currentConfiguration;
    // final screenName = config.last.route.name;
    // if (screenName != null) {
    //   final pathParams = config.pathParameters;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
