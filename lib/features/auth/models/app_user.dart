// ignore_for_file: public_member_api_docs, sort_constructors_first
typedef UserID = String;

class AppUser {
  const AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.surname,
    this.imgUrl,
    this.displayName,
  });

  final UserID uid;
  final String email;
  final String name;
  final String surname;
  final String? imgUrl;
  final String? displayName;

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

  bool get hasImgUrl {
    return imgUrl != null && imgUrl?.isNotEmpty == true;
  }

  String get getInitials {
    String first = name.isNotEmpty ? name[0] : '';
    String second = surname.isNotEmpty ? surname[0] : '';
    if (first.isEmpty && second.isEmpty) {
      if (displayName != null && displayName!.trim().isNotEmpty) {
        final parts = displayName!.trim().split(' ');
        String dFirst = parts.isNotEmpty && parts[0].isNotEmpty
            ? parts[0][0]
            : '';
        String dSecond = parts.length > 1 && parts[1].isNotEmpty
            ? parts[1][0]
            : '';
        if (dFirst.isEmpty && dSecond.isEmpty) return '';
        if (dFirst.isEmpty) return dSecond.toUpperCase();
        if (dSecond.isEmpty) return dFirst.toUpperCase();
        return (dFirst + dSecond).toUpperCase();
      }
      return '';
    }
    if (first.isEmpty) return second.toUpperCase();
    if (second.isEmpty) return first.toUpperCase();
    return (first + second).toUpperCase();
  }
}
