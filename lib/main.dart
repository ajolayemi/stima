import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:stima/app_bootstrap.dart';
import 'package:stima/flavors.dart';

void runMainApp(FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
  await Firebase.initializeApp(options: firebaseOptions);

  if (F.appFlavor != Flavor.prod && kDebugMode) {
    Logger.root.level = Level.ALL;

    Logger.root.onRecord.listen((record) {});
    // android special host - 10.0.2.2
    final host = Platform.isAndroid ? '10.0.2.2' : 'localhost';
    await FirebaseAuth.instance.useAuthEmulator(host, 9099);
    final firestore = FirebaseFirestore.instance;
    firestore.useFirestoreEmulator(host, 8080);
    firestore.settings = Settings(persistenceEnabled: false);
    FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
  }

  final appBootstrap = AppBootstrap();
  final container = await appBootstrap.createProviderContainer();
  final rootWidget = appBootstrap.createRootWidget(container: container);
  runApp(rootWidget);
}
