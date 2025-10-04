// ignore_for_file: public_member_api_docs, sort_constructors_first

class PathParameters {
  final String? email;
  const PathParameters({this.email});



  Map<String, String> toJson() {
    return <String, String>{
      'email': email ?? '',
    };
  }

  factory PathParameters.fromJson(Map<String, String> map) {
    return PathParameters(
      email: map['email'] != null ? map['email'] as String : null,
    );
  }
}
