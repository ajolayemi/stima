import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/providers/auth_providers.dart';

part 'new_password_controller.g.dart';

@riverpod
class NewPasswordController extends _$NewPasswordController {
  AuthRepository get _authRepository => ref.read(authRepositoryProvider);
  @override
  FutureOr<void> build() {
    return null;
  }

  Future<bool> createNewPassword({
    required String newPassword,
    required String confirmationCode,
  }) async {
    state = const AsyncLoading();

    final res = await AsyncValue.guard(
      () async => await _authRepository.createNewPassword(
        newPassword: newPassword,
        confirmationCode: confirmationCode,
      ),
    );

    if (!res.hasError && ref.mounted) {
      state = AsyncData(null);
    } else if (res.hasError && ref.mounted) {
      state = AsyncError(res.error!, StackTrace.current);
    }

    return !state.hasError;
  }
}
