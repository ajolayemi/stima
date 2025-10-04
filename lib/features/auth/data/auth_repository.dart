import 'package:stima/core/enums/app_role.dart';
import 'package:stima/features/auth/models/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> loginWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AppUser?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AppUser?> loginWithGoogle();

  Future<void> logOut();

  Stream<AppUser?> authStateChanges();

  Future<void> refreshUserToken();

  AppUser? get currentUser;

  Future<AppRole?> getUserRole({bool forceRefreshToken = true});

  Future<bool> sendPasswordResetLink(String email);

  Future<void> createNewPassword({
    required String newPassword,
    required String confirmationCode,
  });
}
