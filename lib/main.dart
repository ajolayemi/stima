import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stima/app_bootstrap.dart';
import 'package:stima/flavors.dart';

void runMainApp(FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
  await Firebase.initializeApp(options: firebaseOptions);

  if (F.appFlavor == Flavor.dev && kDebugMode) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  final appBootstrap = AppBootstrap();
  final container = await appBootstrap.createProviderContainer();
  final rootWidget = appBootstrap.createRootWidget(container: container);
  runApp(rootWidget);
}
