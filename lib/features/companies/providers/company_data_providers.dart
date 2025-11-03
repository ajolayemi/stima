import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/features/companies/models/company.dart';
import 'package:stima/features/companies/providers/company_repo_providers.dart';

part 'company_data_providers.g.dart';

@riverpod
Stream<List<Company>?> companiesStream(Ref ref) {
  return ref.watch(companyRepositoryProvider).watchCompanies();
}

@riverpod
FutureOr<List<Company>?> companiesFuture(Ref ref) {
  return ref.watch(companyRepositoryProvider).fetchCompanies();
}

@riverpod
class CompanySearchController extends _$CompanySearchController {
  @override
  FutureOr<List<Company>> build() async {
    final companies = await ref.watch(companiesFutureProvider.future);
    return companies ?? [];
  }

  void searchCompanies(String query) {
    final allCompanies = ref.read(companiesFutureProvider).value ?? [];
    if (query.isEmpty) {
      state = AsyncValue.data(allCompanies);
    } else {
      final filteredCompanies = allCompanies
          .where(
            (company) =>
                company.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      state = AsyncValue.data(filteredCompanies);
    }
  }
}
