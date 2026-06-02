import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:version/version.dart';

import 'package:stima/config/flavor_configs.dart';
import 'package:stima/core/data/service/data_connect_service.dart';
import 'package:stima/core/enums/app_flavors.dart';
import 'package:stima/core/utils/env_utils.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';

class AppUtils {
  const AppUtils._();

  static String obfuscateEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return '${username[0]}***@$domain';
    }

    final visible = username.substring(0, 2);
    final obfuscated = '*' * (username.length - 2);
    return '$visible$obfuscated@$domain';
  }

  static void resetPasswordVisibilityProviders(WidgetRef ref) {
    ref.invalidate(showPasswordProvider);
    ref.invalidate(showConfirmPasswordProvider);
  }

  static String getStoreRedirectUri({String? androidPackageName}) {
    if (Platform.isAndroid &&
        androidPackageName != null &&
        androidPackageName.isNotEmpty) {
      return 'https://play.google.com/store/apps/details?id=$androidPackageName';
    } else if (Platform.isIOS) {
      return 'https://apps.apple.com/app/${FlavorConfig.iosStoreId}';
    }
    return '';
  }

  static bool needsToUpdateApp({
    String? currentVersion,
    String? requiredVersion,
  }) {
    if (currentVersion == null ||
        currentVersion.isEmpty ||
        requiredVersion == null ||
        requiredVersion.isEmpty) {
      return false;
    }

    final parsedCurrentVersion = Version.parse(currentVersion);
    final parsedRequired = Version.parse(requiredVersion);
    return parsedRequired > parsedCurrentVersion;
  }

  static bool pageCanPop(BuildContext context) {
    final currentConfig = GoRouter.of(
      context,
    ).routerDelegate.currentConfiguration;
    final lastMatch = currentConfig.matches.isEmpty ? null : currentConfig.last;
    final location = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches.uri
        : currentConfig.uri;

    return location.pathSegments.length > 1;
  }

  static AppFlavor? get appCurrentFlavor {
    return AppFlavor.values.firstWhereOrNull(
      (element) => element.name == appFlavor,
    );
  }

  static String get title {
    switch (appCurrentFlavor) {
      case AppFlavor.dev:
        return 'Stime in campo DEV';
      case AppFlavor.stg:
        return 'Stime in campo STG';
      case AppFlavor.prod || _:
        return 'Stime in campo';
    }
  }

  static String get firebaseLocalHost {
    return Platform.isAndroid ? '192.168.1.115' : 'localhost';
  }

  static void startEmulators() {
    if (kDebugMode && EnvUtils.useFirebaseEmulator) {
      FirebaseAuth.instance.useAuthEmulator(firebaseLocalHost, 9099);
      FirebaseFunctions.instance.useFunctionsEmulator(firebaseLocalHost, 5001);
      FirebaseDataConnectService.startLocalEmulators();
    }
  }
}
