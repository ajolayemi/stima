import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/data/firebase_auth_repository.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return FirebaseAuthRepository();
}

@Riverpod(keepAlive: true)
Stream<void> authStateChanges(Ref ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
}
