import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stima/core/models/app_device_info.dart';

class AppDeviceInfoService {
  const AppDeviceInfoService();

  Future<PackageInfo> getPlatformInfo() async {
    return await PackageInfo.fromPlatform();
  }

  Future<AppDeviceInfo> getAppDeviceInfo() async {
    final platformInfo = await getPlatformInfo();

    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return AppDeviceInfo(
        idDevice: androidInfo.id,
        appVersion: platformInfo.version,
        os: 'Android',
        osVersion: androidInfo.version.release,
        producer: androidInfo.brand,
        model: androidInfo.model,
        appBuildNumber: platformInfo.buildNumber,
        appPackageName: platformInfo.packageName,
      );
    }

    final iosInfo = await DeviceInfoPlugin().iosInfo;
    return AppDeviceInfo(
      idDevice: iosInfo.identifierForVendor ?? '',
      appVersion: platformInfo.version,
      os: iosInfo.systemName,
      osVersion: iosInfo.systemVersion,
      producer: 'Apple',
      model: iosInfo.utsname.machine,
      appBuildNumber: platformInfo.buildNumber,
      appPackageName: platformInfo.packageName,
    );
  }
}
