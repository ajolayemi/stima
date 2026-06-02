import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/exceptions/app_exception.dart';

part 'error_logger.g.dart';

abstract class ErrorLogger {
  void logError(Object error, StackTrace? stackTrace);
  void logAppException(AppException exception);
}

class FirebaseErrorLogger implements ErrorLogger {
  static final _crashlytics = FirebaseCrashlytics.instance;
  @override
  void logError(Object error, StackTrace? stackTrace) {
    _crashlytics.recordError(error, stackTrace);
  }

  @override
  void logAppException(AppException exception) {
    _crashlytics.recordError(exception, exception.stackTrace);
  }
}

@Riverpod(keepAlive: true)
ErrorLogger errorLogger(Ref ref) {
  return FirebaseErrorLogger();
}
