import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/data/service/app_device_info_service.dart';
import 'package:stima/core/models/app_device_info.dart';

part 'app_device_info_provider.g.dart';

@Riverpod(keepAlive: true)
AppDeviceInfoService appDeviceInfoService(Ref ref) {
  return AppDeviceInfoService();
}

@Riverpod(keepAlive: true)
FutureOr<AppDeviceInfo> appDeviceInfo(Ref ref) async {
  final service = ref.read(appDeviceInfoServiceProvider);
  return await service.getAppDeviceInfo();
}
