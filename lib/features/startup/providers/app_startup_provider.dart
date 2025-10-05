import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/providers/app_device_info_provider.dart';

part 'app_startup_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<bool> appStartup(Ref ref) async {
  // Init app device info here
  await ref.read(appDeviceInfoProvider.future);
  return Future.value(true);
}
