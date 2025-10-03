// Helper class to initialize services and configure the error handlers
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stima/app.dart';
import 'package:stima/core/observers/async_error_observer.dart';
import 'package:stima/core/exceptions/error_logger.dart';

class AppBootstrap {
  Future<ProviderContainer> createProviderContainer() async {
    return ProviderContainer(observers: [AsyncErrorLoggerObserver()]);
  }

  /// Create the root widget that should be passed to [runApp]
  UncontrolledProviderScope createRootWidget({
    required ProviderContainer container,
  }) {
    // // Register the timeago messages
    // registerTimeagoMessages();

    // * Register error handlers. For more info, see:
    // * https://docs.flutter.dev/testing/errors
    final errorLogger = container.read(errorLoggerProvider);
    registerErrorHandlers(errorLogger);
    return UncontrolledProviderScope(
      container: container,
      child: const SurveyApp(),
    );
  }

  // Future<SettingsController> bootSettingsController() async {
  //   // Set up the SettingsController, which will glue user settings to multiple
  //   // Flutter Widgets.
  //   final settingsController = SettingsController(SettingsService());

  //   // Load the user's preferred theme while the splash screen is displayed.
  //   // This prevents a sudden theme change when the app is first displayed.
  //   await settingsController.loadSettings();

  //   return settingsController;
  // }

  // Register Flutter error handlers
  void registerErrorHandlers(ErrorLogger errorLogger) {
    // * Show some error UI if any uncaught exception happens
    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
      errorLogger.logError(details.exception, details.stack);
    };
    // * Handle errors from the underlying platform/OS
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      errorLogger.logError(error, stack);
      return true;
    };
    // * Show some error UI when any widget in the app fails to build
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An error occurred'),
        ),
        body: Center(child: Text(details.toString())),
      );
    };
  }
}
