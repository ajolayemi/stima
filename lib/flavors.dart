enum Flavor {
  dev,
  stg,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Stime in campo DEV';
      case Flavor.stg:
        return 'Stime in campo STG';
      case Flavor.prod:
        return 'Stime in campo';
    }
  }

}
