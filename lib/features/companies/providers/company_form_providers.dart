import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/companies/models/company_form_data.dart';
import 'package:stima/features/companies/models/company_form_file_info.dart';

part 'company_form_providers.g.dart';

@Riverpod(keepAlive: true)
class CompanyFormDataNotifier extends _$CompanyFormDataNotifier {
  @override
  CompanyFormData? build() {
    return null;
  }

  void updateFileInfo(CompanyFormFileInfo? info) {
    state = state?.copyWith(fileInfo: info);
  }

  void resetFileInfo() {
    state = state?.copyWith(fileInfo: CompanyFormFileInfo.data());
  }

  void updateGeneralInfo({
    required String companyName,
    required String contactPersonName,
    required String phoneNumber,
    String? email,
    String? address,
  }) {
    if (state == null) {
      state = CompanyFormData(
        companyName: companyName,
        contactPersonName: contactPersonName,
        phoneNumber: phoneNumber,
        email: email,
        address: address,
      );
      return;
    }
    state = state?.copyWith(
      companyName: companyName,
      contactPersonName: contactPersonName,
      phoneNumber: phoneNumber,
      email: email,
      address: address,
    );
  }
}

@riverpod
CompanyFormFileInfo? companyFormFileInfo(Ref ref) {
  return ref.watch(companyFormDataProvider.select((value) => value?.fileInfo));
}
