import 'package:stima/features/auth/data/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  @override
  Stream<void> authStateChanges() {
    // TODO: implement authStateChanges
    return Stream.empty();
  }
}