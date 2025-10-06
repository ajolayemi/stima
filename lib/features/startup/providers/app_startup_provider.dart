import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/domain/models/app_startup_result.dart';
import 'package:stima/core/providers/app_device_info_provider.dart';
import 'package:stima/core/providers/config_providers.dart';
import 'package:stima/core/utils/app_utils.dart';

part 'app_startup_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<AppStartupResult> appStartup(Ref ref) async {
  // Init app device info here
  final deviceInfo = await ref.read(appDeviceInfoProvider.future);
  // setup remote config
  await ref.read(configRepositoryProvider).setup();

  final remoteConfig = ref.read(versionUpdateConfigProvider);

  return AppStartupResult(
    startupCompleted: true,
    updateRequired: AppUtils.needsToUpdateApp(
      currentVersion: deviceInfo.appVersion,
      requiredVersion: remoteConfig.requiredVersion,
    ),
    androidPackageName: deviceInfo.appPackageName,
  );
}
