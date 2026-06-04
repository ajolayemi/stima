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
    @Default(true) bool isActive,
    String? kmlMapFileLink,
  }) = _Company;

  // Factory constructor for creating a new Company instance
  @JsonSerializable(explicitToJson: true)
  factory Company.fromForm(CompanyFormData formData) {
    return Company(
      name: formData.companyName,
      contactPersonName: formData.contactPersonName,
      phoneNumber: formData.phoneNumber,
      email: formData.email,
      address: formData.address,
      isActive: true,
      kmlMapFileLink: formData.fileInfo?.kmlMapFileLink,
    );
  }

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  bool get hasPhoneNumber => phoneNumber != null && phoneNumber!.isNotEmpty;
}
