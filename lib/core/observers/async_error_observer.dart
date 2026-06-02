import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:stima/core/di/service_locator.dart';
import 'package:stima/core/exceptions/error_logger.dart';

/// Error logger class to keep track of all AsyncError states that are set
/// by the controllers in the app
final class AsyncErrorLoggerObserver extends ProviderObserver {
  static final _logger  = Logger('AsyncErrorLoggerObserver');
  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    // context.container.
    // print('here: $context');
    // final errorLogger = context.read(errorLoggerProvider);
    // final error = _findError(newValue);

    // if (error != null) {
    //   if (error.error is AppException) {
    //     // only prints the AppException data
    //     errorLogger.logAppException(error.error as AppException);
    //   } else {
    //     // prints everything including the stack trace
    //     errorLogger.logError(error, error.stackTrace);
    //   }
    // }
  }

  // AsyncError<dynamic>? _findError(Object? value) {
  //   if (value is AsyncError) {
  //     return value;
  //   } else {
  //     return null;
  //   }
  // }

  @override
  void providerDidFail(
    ProviderObserverContext context,
    Object error,
    StackTrace stackTrace,
  ) {
    ServiceLocator.get<ErrorLogger>().logError(error, stackTrace);
    _logger.severe('Provider failed: ${context.provider}', error, stackTrace);
    super.providerDidFail(context, error, stackTrace);
  }
}
