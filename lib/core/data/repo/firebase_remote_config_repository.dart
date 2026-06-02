import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logging/logging.dart';
import 'package:stima/core/data/repo/config_repository.dart';
import 'package:stima/core/data/service/local_file_service.dart';
import 'package:stima/core/domain/models/version_update_config.dart';
import 'package:stima/core/enums/config_keys.dart';

class FirebaseRemoteConfigRepository implements ConfigRepository {
  FirebaseRemoteConfigRepository(this._configInstance);
  final FirebaseRemoteConfig _configInstance;

  final _crashlytics = FirebaseCrashlytics.instance;
  final _logger = Logger('FirebaseRemoteConfigRepository');

  T? _getConfig<T>(T? Function() getterCallback) {
    try {
      return getterCallback();
    } catch (e, st) {
      _crashlytics.recordError(e, st);
      _logger.severe('error occurred while fetching config, $e, $st');
      return null;
    }
  }

  @override
  Future<void> setup() async {
    try {
      _logger.info('setting up remote config with firebase');

      final defaults = await LocalFileService.getRemoteConfigDefault();

      await _configInstance.setDefaults(defaults);

      if (_configInstance.lastFetchStatus == .noFetchYet) {
        _logger.info('fetching remote config for the first time');
        await _configInstance.fetchAndActivate();
      }
    } catch (e, st) {
      _crashlytics.recordError(e, st);
      _logger.severe('error occurred while setting up remote config, $e, $st');
      return;
    }
  }

  @override
  VersionUpdateConfig? getVersionUpdateConfig() {
    return _getConfig(() {
      final value = jsonDecode(
        _configInstance.getValue(ConfigKeys.versionUpdateConfig.key).asString(),
      );
      return VersionUpdateConfig.fromJson(value as Map<String, dynamic>);
    });
  }
}
