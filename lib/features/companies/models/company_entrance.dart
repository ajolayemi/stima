import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_entrance.freezed.dart';
part 'company_entrance.g.dart';

@freezed
abstract class CompanyEntrance with _$CompanyEntrance {
  const CompanyEntrance._();
  @JsonSerializable(explicitToJson: true)
  const factory CompanyEntrance({
    required String companyId,
    required double lat,
    required double lng,
    required String entranceName,
    required String entranceStringAddress,
  }) = _CompanyEntrance;

  factory CompanyEntrance.fromJson(Map<String, dynamic> json) =>
      _$CompanyEntranceFromJson(json);
}
