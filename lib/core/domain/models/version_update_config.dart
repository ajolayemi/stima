// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'version_update_config.g.dart';

@JsonSerializable()
class VersionUpdateConfig {
  final String? requiredVersion;
  VersionUpdateConfig({this.requiredVersion});

  factory VersionUpdateConfig.fromJson(json) =>
      _$VersionUpdateConfigFromJson(json);

  Map<String,dynamic> toJson() => _$VersionUpdateConfigToJson(this);
}
