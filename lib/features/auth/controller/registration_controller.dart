import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';

part 'registration_controller.g.dart';

@riverpod
class RegistrationController extends _$RegistrationController {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<void> registerWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async => await _authRepository.loginWithGoogle(),
    );
  }
}
