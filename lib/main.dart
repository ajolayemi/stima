import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:stima/app_bootstrap.dart';
import 'package:stima/core/enums/app_flavors.dart';
import 'package:stima/core/utils/app_utils.dart';

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

  if (AppUtils.appCurrentFlavor == AppFlavor.dev && kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  final appBootstrap = AppBootstrap();
  final container = await appBootstrap.createProviderContainer();
  final rootWidget = appBootstrap.createRootWidget(container: container);
  runApp(rootWidget);
}
