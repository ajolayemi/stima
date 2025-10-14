import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/companies/service/company_service.dart';

part 'add_company_controller.g.dart';

@riverpod
class AddCompanyController extends _$AddCompanyController {
  CompanyService get _companyService => ref.read(companyServiceProvider);
  @override
  FutureOr<void> build() async {
    return null;
  }

  Future<void> pickKmlFile() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(
      () async => await _companyService.pickCompanyKmlFile(),
    );
  }
}
