// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_lat_lng.freezed.dart';
part 'app_lat_lng.g.dart';

@freezed
abstract class AppLatLng with _$AppLatLng {
  @JsonSerializable(explicitToJson: true)
  const factory AppLatLng({
    required double latitude,
    required double longitude,
  }) = _AppLatLng;

  factory AppLatLng.fromJson(Map<String, dynamic> json) =>
      _$AppLatLngFromJson(json);
}
