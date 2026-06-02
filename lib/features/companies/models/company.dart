import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stima/features/companies/models/company_form_data.dart';

part 'company.freezed.dart';
part 'company.g.dart';


@freezed
abstract class Company with _$Company {
  const Company._();

  @JsonSerializable(explicitToJson: true)
  const factory Company({
    String? id,
    String? name,
    String? contactPersonName,
    String? phoneNumber,
    String? email,
    String? address,
    @Default(false) bool isActive,
    String? kmlMapFileLink,
  }) = _Company;

  factory Company.fromForm(CompanyFormData formData) {
    return Company(
      name: formData.companyName,
      contactPersonName: formData.contactPersonName,
      phoneNumber: formData.phoneNumber,
      email: formData.email,
      address: formData.address,
      kmlMapFileLink: formData.fileInfo?.kmlMapFileLink,
    );
  }

  bool get hasPhoneNumber => phoneNumber != null && phoneNumber!.isNotEmpty;

  factory Company.fromJson(Map<String, dynamic> json) => _$CompanyFromJson(json);
}
