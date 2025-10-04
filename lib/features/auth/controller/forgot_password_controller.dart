import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';

part 'forgot_password_controller.g.dart';

@riverpod
class ForgotPasswordController extends _$ForgotPasswordController {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> sendPasswordRecoveryMail(String email) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () async => await _authRepository.sendPasswordResetLink(email),
    );
    return !state.hasError;
  }
}
