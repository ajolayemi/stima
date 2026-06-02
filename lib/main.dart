import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:stima/app_bootstrap.dart';
import 'package:stima/core/di/service_locator.dart';
import 'package:stima/core/utils/env_utils.dart';

void main() {
  runMainApp();
}

void runMainApp({FirebaseOptions? firebaseOptions}) async {
  final logger = Logger('AppStima');
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (record.loggerName == 'GoRouter') {
        return;
      }
      debugPrint(
        '[${record.level.name}]: ${record.time}: ${record.loggerName}: ${record.message}',
      );
    });
  }

  final firebaseApp = await Firebase.initializeApp();
  final options = firebaseApp.options;
  logger.info(
    'Firebase initialized for app id: ${options.appId} and project id: ${options.projectId}',
  );

  if (kDebugMode && EnvUtils.useFirebaseEmulator) {
    final host = Platform.isAndroid ? '192.168.1.115' : 'localhost';
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    final firestore = FirebaseFirestore.instance;
    firestore.useFirestoreEmulator(host, 8080);
    firestore.settings = Settings(persistenceEnabled: false);
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
  }

  ServiceLocator.init();

  final appBootstrap = AppBootstrap();
  final container = await appBootstrap.createProviderContainer();
  final rootWidget = appBootstrap.createRootWidget(container: container);
  runApp(rootWidget);
}
