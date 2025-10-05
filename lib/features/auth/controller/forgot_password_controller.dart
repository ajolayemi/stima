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
    final res = await AsyncValue.guard(
      () async => await _authRepository.sendPasswordResetLink(email),
    );
    if (!res.hasError && ref.mounted) {
      state = AsyncData(null);
    } else if (res.hasError && ref.mounted) {
      state = AsyncError(res.error!, StackTrace.current);
    }
    return !state.hasError;
  }
}
