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
    final res = await AsyncValue.guard(
      () async => await _authRepository.loginWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
    if (!res.hasError && ref.mounted) {
      state = AsyncData(null);
    } else if (res.hasError && ref.mounted) {
      state = AsyncError(res.error!, StackTrace.current);
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    final res = await AsyncValue.guard(
      () async => await _authRepository.loginWithGoogle(),
    );
    if (!res.hasError && ref.mounted) {
      state = AsyncData(null);
    }
    if (res.hasError && ref.mounted) {
      state = AsyncError(res.error!, StackTrace.current);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    final res = await AsyncValue.guard(
      () async => await _authRepository.logOut(),
    );
    if (!res.hasError && ref.mounted) {
      state = AsyncData(null);
    } else if (res.hasError && ref.mounted) {
      state = AsyncError(res.error!, StackTrace.current);
    }
  }
}
