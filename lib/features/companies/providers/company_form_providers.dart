import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/companies/models/company_form_data.dart';

part 'company_form_providers.g.dart';

@Riverpod(keepAlive: true)
class CompanyFormDataNotifier extends _$CompanyFormDataNotifier {
  @override
  CompanyFormData build() {
    return CompanyFormData();
  }

  void updateFileInfo(CompanyFormFileInfo? info) {
    state = state.copyWith(fileInfo: info);
  }

  void resetFileInfo() {
    state = state.copyWith(fileInfo: CompanyFormFileInfo.data());
  }
}

@riverpod
CompanyFormFileInfo? companyFormFileInfo(Ref ref) {
  return ref.watch(companyFormDataProvider.select((value) => value.fileInfo));
}
