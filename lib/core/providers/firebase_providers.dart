import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_providers.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(Ref ref) {
  return FirebaseAuth.instance;
}

@Riverpod(keepAlive: true)
FirebaseRemoteConfig firebaseRemoteConfig(Ref ref) {
  return FirebaseRemoteConfig.instance;
}

@Riverpod(keepAlive: true)
void firebaseRemoteConfigStream(Ref ref) {
  final configInstance = ref.read(firebaseRemoteConfigProvider);
  final sub = configInstance.onConfigUpdated.listen((data) async {
    await configInstance.activate();
  });

  ref.onDispose(() {
    sub.cancel();
  });
}

