import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_startup_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<void> appStartup(Ref ref) async {
  await Future.delayed(const Duration(seconds: 5));
  return Future.value();
}
