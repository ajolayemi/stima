import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';

part 'login_controller.g.dart';

@Riverpod(keepAlive: false)
class LoginController extends _$LoginController {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () async => await _authRepository.loginWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async => await _authRepository.loginWithGoogle());
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() async => await _authRepository.logOut());
  }
}
