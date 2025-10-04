// ignore_for_file: public_member_api_docs, sort_constructors_first

class PathParameters {
  final String? email;
  final String? passwordResetConfirmationCode;
  const PathParameters({this.email, this.passwordResetConfirmationCode});

  Map<String, String> toJson() {
    final map = <String, String>{};
    if (email != null) {
      map['email'] = email!;
    }
    if (passwordResetConfirmationCode != null) {
      map['code'] = passwordResetConfirmationCode!;
    }
    return map;
  }

  factory PathParameters.fromJson(Map<String, String> map) {
    return PathParameters(
      email: map['email'] != null ? map['email'] as String : null,
      passwordResetConfirmationCode: map['code'] != null
          ? map['code'] as String
          : null,
    );
  }
}
