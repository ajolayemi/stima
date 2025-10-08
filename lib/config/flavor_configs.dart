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

  // TODO: complete implementation if necessary
  static String get iosStoreId {
    switch (F.appFlavor) {
      case Flavor.dev:
        return "id";
      case Flavor.stg:
        return "id";
      case Flavor.prod:
        return "id";
    }
  }

  static String get flavorStringForVersion {
    switch (F.appFlavor) {
      case Flavor.dev:
        return "DEV";
      case Flavor.stg:
        return "STG";
      case Flavor.prod:
        return "";
    }
  }
}
