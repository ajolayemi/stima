import 'package:stima/flavors.dart';

class FlavorConfig {
  // TODO: Add configs for stg and PROD
  static String get firebaseHostUrl {
    switch (F.appFlavor) {
      case Flavor.dev:
        return "https://stime-dev-473921.web.app";
      case Flavor.stg:
        return "https://staging.myapp.web.app";
      case Flavor.prod:
        return "https://myapp.web.app";
    }
  }
}
