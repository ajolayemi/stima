import 'package:stima/features/companies/models/company.dart';

abstract class CompanyRepository {
  Future<void> addCompany(Company? company);

  Future<List<Company>> fetchCompanies();

  Stream<List<Company>> watchCompanies();

  Future<Company?> getCompany(String companyId);
}
