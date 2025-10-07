// ignore_for_file: public_member_api_docs, sort_constructors_first
class AppDeviceInfo {
  final String idDevice;
  final String appVersion;
  final String os;
  final String osVersion;
  final String producer;
  final String model;
  final String appBuildNumber;
  final String appPackageName;
  final String? versionStringForUi;
  const AppDeviceInfo({
    required this.idDevice,
    required this.appVersion,
    required this.os,
    required this.osVersion,
    required this.producer,
    required this.model,
    required this.appBuildNumber,
    required this.appPackageName,
    required this.versionStringForUi,
  });
}
