import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:stima/core/enums/app_role.dart';
import 'package:stima/core/providers/app_device_info_provider.dart';
import 'package:stima/core/providers/firebase_providers.dart';
import 'package:stima/core/providers/google_auth_providers.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/data/firebase_auth_repository.dart';
import 'package:stima/features/auth/models/app_user.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  final googleSignIn = ref.read(googleSignInProvider);
  final deviceInfo = ref.watch(appDeviceInfoProvider).value;
  return FirebaseAuthRepository(firebaseAuth, googleSignIn, deviceInfo);
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}

@Riverpod(keepAlive: true)
FutureOr<AppRole?> userRole(Ref ref) async {
  return await ref.read(authRepositoryProvider).getUserRole();
}

@riverpod
class LoginButtonEnabled extends _$LoginButtonEnabled {
  @override
  bool build() {
    return false;
  }

  void toggle(String email, String pswd) {
    state = email.isNotEmpty && pswd.isNotEmpty;
  }
}


@riverpod
class ShowPassword extends _$ShowPassword {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

@riverpod
class ShowConfirmPassword extends _$ShowConfirmPassword {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
