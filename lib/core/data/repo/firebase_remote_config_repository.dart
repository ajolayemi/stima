import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:stima/core/data/repo/config_repository.dart';
import 'package:stima/core/domain/models/version_update_config.dart';
import 'package:stima/core/enums/config_keys.dart';

class FirebaseRemoteConfigRepository implements ConfigRepository {
  FirebaseRemoteConfigRepository(this._configInstance);
  final FirebaseRemoteConfig _configInstance;

  @override
  Future<void> setup() async {
    await _configInstance.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 15),
        minimumFetchInterval: const Duration(hours: 12),
      ),
    );

    final configActivated = await _configInstance.fetchAndActivate();
    await _configInstance.setDefaults({
      ConfigKeys.versionUpdateConfig.key: "{}",
    });
    // TODO: add correct logger here
    debugPrint(
      'FirebaseRemoteConfigRepository: config activated - $configActivated',
    );
  }

  @override
  VersionUpdateConfig getVersionUpdateConfig() {
    final value = jsonDecode(
      _configInstance.getValue(ConfigKeys.versionUpdateConfig.key).asString(),
    );

    return VersionUpdateConfig.fromJson(value as Map<String, dynamic>);
  }
}
