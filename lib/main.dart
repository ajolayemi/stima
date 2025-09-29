import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stima/app.dart';
import 'package:stima/flavors.dart';

void runMainApp(FirebaseOptions firebaseOptions) async {
  WidgetsFlutterBinding.ensureInitialized();
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const App());
}
