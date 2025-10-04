import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stima/config/flavor_configs.dart';
import 'package:stima/core/enums/app_role.dart';
import 'package:stima/core/models/app_device_info.dart';
import 'package:stima/core/utils/extensions/exceptions_extension.dart';
import 'package:stima/features/auth/data/auth_repository.dart';
import 'package:stima/features/auth/models/app_user.dart';
import 'package:stima/features/auth/models/firebase_app_user.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._googleSignIn, this._deviceInfo);

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final AppDeviceInfo? _deviceInfo;

  User? get _firebaseUser => _auth.currentUser;

  @override
  Future<AppRole?> getUserRole({bool forceRefreshToken = true}) async {
    final tokenResult = await _firebaseUser?.getIdTokenResult(
      forceRefreshToken,
    );
    final role = tokenResult?.claims?['role'].toString() ?? '';
    return role.toAppRole();
  }

  @override
  Stream<AppUser?> authStateChanges() {
    return _auth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      } else {
        return FirebaseAppUser(firebaseUser: firebaseUser);
      }
    });
  }

  @override
  AppUser? get currentUser {
    if (_firebaseUser == null) {
      return null;
    }
    return FirebaseAppUser(firebaseUser: _firebaseUser!);
  }

  @override
  Future<AppUser?> loginWithGoogle() async {
    try {
      // Initialize
      await _googleSignIn.initialize();
      // Trigger the authentication flow
      final googleUser = await _googleSignIn.authenticate();

      // Obtain the auth details from the request
      final authDetails = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: authDetails.idToken,
      );

      final firebaseUserCredential = await _auth.signInWithCredential(
        credential,
      );

      final user = firebaseUserCredential.user;

      if (user == null) {
        return null;
      } else {
        return FirebaseAppUser(firebaseUser: user);
      }
    } on GoogleSignInException catch (gSignInEr, st) {
      throw gSignInEr.toAppException(st) ?? gSignInEr;
    } on FirebaseAuthException catch (firebaseEr, st) {
      throw firebaseEr.toAppException(st) ?? firebaseEr;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppUser?> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return null;
      }
      return FirebaseAppUser(firebaseUser: user);
    } on FirebaseAuthException catch (authException, st) {
      throw authException.toAppException(st) ?? authException;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AppUser?> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return null;
      }
      return FirebaseAppUser(firebaseUser: user);
    } on FirebaseAuthException catch (authException, st) {
      throw authException.toAppException(st) ?? authException;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<void> refreshUserToken() async {
    await _firebaseUser?.getIdTokenResult(true);
  }

  @override
  Future<bool> sendPasswordResetLink(String email) async {
    try {
      final firebaseHostUrl = FlavorConfig.firebaseHostUrl;
      final isAndroid = Platform.isAndroid;
      final isIos = Platform.isIOS;
      final actionSettings = ActionCodeSettings(
        url: '$firebaseHostUrl/verify?email=$email',
        iOSBundleId: isIos ? _deviceInfo?.appPackageName : null,
        androidPackageName: isAndroid ? _deviceInfo?.appPackageName : null,
        handleCodeInApp: true,
      );
      await _auth.sendPasswordResetEmail(
        email: email,
        actionCodeSettings: actionSettings,
      );
      return true;
    } on FirebaseAuthException catch (authException, st) {
      throw authException.toAppException(st) ?? authException;
    } catch (e) {
      rethrow;
    }
  }
}
