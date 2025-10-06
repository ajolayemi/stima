import 'package:stima/core/domain/models/version_update_config.dart';

abstract class ConfigRepository {
  Future<void> setup();
  VersionUpdateConfig getVersionUpdateConfig();
}
