import 'package:stima/config/routes/route_enums.dart';

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

  bool get isLoginOrRegister {
    return isLogin || isRegister;
  }
}
