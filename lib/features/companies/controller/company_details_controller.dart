import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/di/service_locator.dart';
import 'package:stima/features/companies/data/company_repository.dart';
import 'package:stima/features/companies/models/company.dart';

part 'company_details_controller.freezed.dart';
part 'company_details_controller.g.dart';

@freezed
abstract class CompanyDetailsControllerState
    with _$CompanyDetailsControllerState {
  const factory CompanyDetailsControllerState({Company? details}) =
      _CompanyDetailsControllerState;
}

@riverpod
class CompanyDetailsController extends _$CompanyDetailsController {

    CompanyRepository get _companyRepo {
    return ServiceLocator.get<CompanyRepository>();
  }
  @override
  FutureOr<CompanyDetailsControllerState> build(String companyId) async {
    final details = await _companyRepo.getCompany(companyId);
    return CompanyDetailsControllerState(details: details);
  }
}
