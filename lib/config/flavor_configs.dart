import 'package:stima/core/enums/app_flavors.dart';
import 'package:stima/core/utils/app_utils.dart';

class FlavorConfig {
  // TODO: Add configs for stg and PROD
  static String get firebaseHostUrl {
    switch (AppUtils.appCurrentFlavor) {
      case AppFlavor.dev:
        return "https://stime-dev-473921.web.app";
      case AppFlavor.stg:
        return "https://staging.myapp.web.app";
      case AppFlavor.prod || _:
        return "https://myapp.web.app";
    }
  }

  // TODO: complete implementation if necessary
  static String get iosStoreId {
    switch (AppUtils.appCurrentFlavor) {
      case AppFlavor.dev:
        return "id";
      case AppFlavor.stg:
        return "id";
      case AppFlavor.prod || _:
        return "id";
    }
  }

  static String get flavorStringForVersion {
    switch (AppUtils.appCurrentFlavor) {
      case AppFlavor.dev:
        return "DEV";
      case AppFlavor.stg:
        return "STG";
      case AppFlavor.prod || _:
        return "";
    }
  }
}
