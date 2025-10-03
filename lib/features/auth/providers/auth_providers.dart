import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/enums/app_role.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/data/firebase_auth_repository.dart';
import 'package:stima/shared/providers/firebase_providers.dart';
import 'package:stima/shared/providers/google_auth_providers.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final firebaseAuth = ref.read(firebaseAuthProvider);
  final googleSignIn = ref.read(googleSignInProvider);
  return FirebaseAuthRepository(firebaseAuth, googleSignIn);
}

@Riverpod(keepAlive: true)
Stream<void> authStateChanges(Ref ref) {
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
class LoginShowPassword extends _$LoginShowPassword {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

@riverpod
class RegistrationShowPassword extends _$RegistrationShowPassword {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

@riverpod
class RegistrationShowConfirmPassword
    extends _$RegistrationShowConfirmPassword {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}
