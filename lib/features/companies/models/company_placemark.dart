import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stima/core/models/app_lat_lng.dart';

part 'company_placemark.g.dart';
part 'company_placemark.freezed.dart';

@freezed
abstract class CompanyPlacemark with _$CompanyPlacemark {
  const CompanyPlacemark._();
  @JsonSerializable(explicitToJson: true)
  const factory CompanyPlacemark({
    /// A unique identifier for the placemark
    required String id,

    /// The id of the company associated with the placemark
    required String companyId,

    /// The name of the company associated with the placemark
    required String companyName,

    /// The list of this placemark's coordinates
    required List<AppLatLng> coordinates,

    /// The centroid coordinates of this placemark
    required AppLatLng centroidCoordinates,

    /// Hex color code for the placemark
    String? hexColorCode,
  }) = _CompanyPlacemark;

  factory CompanyPlacemark.fromJson(Map<String, dynamic> json) =>
      _$CompanyPlacemarkFromJson(json);
}
