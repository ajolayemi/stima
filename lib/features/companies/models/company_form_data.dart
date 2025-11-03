// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stima/features/companies/models/company_form_file_info.dart';

part 'company_form_data.freezed.dart';

@freezed
abstract class CompanyFormData with _$CompanyFormData {
  const factory CompanyFormData({
    required String companyName,
    required String contactPersonName,
    required String phoneNumber,
    String? email,
    String? address,
    CompanyFormFileInfo? fileInfo,
  }) = _CompanyFormData;
}
