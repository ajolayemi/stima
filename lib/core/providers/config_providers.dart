import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/data/repo/config_repository.dart';
import 'package:stima/core/data/repo/firebase_remote_config_repository.dart';
import 'package:stima/core/domain/models/version_update_config.dart';
import 'package:stima/core/providers/firebase_providers.dart';

part 'config_providers.g.dart';

@Riverpod(keepAlive: true)
ConfigRepository configRepository(Ref ref) {
  final firebaseRemoteConfigInstance = ref.watch(firebaseRemoteConfigProvider);
  return FirebaseRemoteConfigRepository(firebaseRemoteConfigInstance);
}

@Riverpod(keepAlive: true)
VersionUpdateConfig? versionUpdateConfig(Ref ref) {
  final configRepo = ref.watch(configRepositoryProvider);
  return configRepo.getVersionUpdateConfig();
}
