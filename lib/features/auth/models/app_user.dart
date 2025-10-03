// ignore_for_file: public_member_api_docs, sort_constructors_first
typedef UserID = String;

class AppUser {
  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.surname,
  });

  final UserID uid;
  final String email;
  final String name;
  final String surname;

  // * Here we override methods from [Object] directly rather than using
  // * [Equatable], since this class will be subclassed or implemented
  // * by other classes.
  @override
  bool operator ==(covariant AppUser other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.email == email &&
        other.name == name &&
        other.surname == surname;
  }

  @override
  int get hashCode {
    return uid.hashCode ^ email.hashCode ^ name.hashCode ^ surname.hashCode;
  }
}
