import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/core/widgets/app_error_widget.dart';
import 'package:stima/core/widgets/loading_widget.dart';
import 'package:stima/shared/widgets/app_scaffold.dart';

/// A generic widget meant to be used to build ui starting from riverpod's [AsyncValue]
///
/// [asyncValue] - the [AsyncValue] on which to base the UI
///
/// [onData] - callback for when [asyncValue] is ready
///
/// [onError] - optional callback to handle [asyncValue]'s eventual error.
/// If not provided, the standard [ErrorWidget] is displayed
///
/// [onLoading] - optional callback to handle when [asyncValue] is still loading.
/// If not provided, a standard [LoadingWidget] is displayed
class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.asyncValue,
    required this.onData,
    this.onError,
    this.onLoading,
    this.onErrorRetry,
  });

  final AsyncValue<T> asyncValue;
  final Widget Function(T?) onData;
  final Widget Function(Object? error, StackTrace? st)? onError;
  final Widget Function()? onLoading;
  final VoidCallback? onErrorRetry;

  Widget _onLoadingWrapper() {
    if (asyncValue.hasValue) {
      return onData.call(asyncValue.value);
    }
    return onLoading?.call() ??
        AnnotatedRegion<SystemUiOverlayStyle>(
          value: .dark,
          child: const AppScaffold(body: LoadingWidget()),
        );
  }

  Widget _onErrorWrapper(Object error, StackTrace stackTrace) {
    if (asyncValue.isLoading ||
        asyncValue.isRefreshing ||
        asyncValue.isReloading) {
      return _onLoadingWrapper();
    } else if (asyncValue.hasValue) {
      return onData.call(asyncValue.value);
    }
    return onError?.call(error, stackTrace) ??
        AppErrorWidget(
          error: error,
          st: stackTrace,
          onRetry: onErrorRetry,
        );
  }

  @override
  Widget build(BuildContext context) {
    return switch (asyncValue) {
      AsyncData(:final value) => onData.call(value),
      AsyncError(:final error, :final stackTrace) => _onErrorWrapper(
        error,
        stackTrace,
      ),
      AsyncLoading() => _onLoadingWrapper(),
    };
  }
}