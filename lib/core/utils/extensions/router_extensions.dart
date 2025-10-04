import 'package:go_router/go_router.dart';
import 'package:stima/config/routes/route_enums.dart';
import 'package:stima/core/models/path_parameters.dart';

extension RouterPathExtensions on String {
  bool get isHome {
    return this == AppRoute.home.path;
  }

  bool get isLogin {
    return this == AppRoute.login.path;
  }

  bool get isRegister {
    return this == AppRoute.register.path;
  }

  bool get isForgotPassword {
    return endsWith(AppRoute.forgotPassword.path);
  }

  bool get isResetPassword {
    return endsWith(AppRoute.resetPassword.path);
  }

  bool get isForgotPasswordSuccessPage {
    return contains('/log-in/forgot-password/success/');
  }

  bool get isLoginOrRegister {
    return isLogin || isRegister;
  }

  bool get isNotProtectedRoute {
    return isLogin ||
        isRegister ||
        isForgotPassword ||
        isResetPassword ||
        isForgotPasswordSuccessPage;
  }
}

extension GoRouterStateX on GoRouterState {
  /// Converts go router path parameters to app class [PathParameters]
  PathParameters toPathParams() {
    return PathParameters.fromJson(pathParameters);
  }

  /// Retrieves the email field from path parameters
  String get emailFromPath {
    return toPathParams().email ?? '';
  }
}
