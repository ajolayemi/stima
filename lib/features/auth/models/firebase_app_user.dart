import 'package:stima/features/auth/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAppUser extends AppUser {
  final User firebaseUser;
  FirebaseAppUser({required this.firebaseUser})
    : super(
        email: firebaseUser.email ?? '',
        uid: firebaseUser.uid,
        name: firebaseUser.displayName ?? '',
        surname: '',
      );
}
