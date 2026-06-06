// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'firebase_callable_func_data.g.dart';

@JsonSerializable(explicitToJson: true)
class FirebaseCallableFuncData {
  @JsonKey(name: 'collection')
  final String collectionName;

  @JsonKey(name: 'data')
  final Map<String, dynamic> data;

  @JsonKey(name: 'should_add_id_to_document')
  /// When true, the cloud function that is called adds an additional "id" field to the created document data
  final bool shouldAddIdToDocument;
  FirebaseCallableFuncData({
    required this.collectionName,
    this.data = const <String, dynamic>{},
    this.shouldAddIdToDocument = true,
  });

  factory FirebaseCallableFuncData.fromJson(Map<String, dynamic> json) =>
      _$FirebaseCallableFuncDataFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseCallableFuncDataToJson(this);
}
