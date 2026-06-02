import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:stima/core/data/service/data_connect_service.dart';
import 'package:stima/dataconnect_generated/generated.dart';
import 'package:stima/features/companies/data/company_repository.dart';
import 'package:stima/features/companies/models/company.dart';

class DataConnectCompanyRepository implements CompanyRepository {
  final _connector = FirebaseDataConnectService.stimaDataConnector;

  QueryRef<GetAllCompaniesData, void> get _getAllCompaniesQuery {
    return _connector.getAllCompanies().ref();
  }

  @override
  Future<void> addCompany(Company? company) async {
    await _connector
        .createCompany(
          name: company?.name ?? '',
          contactPersonName: company?.contactPersonName ?? '',
          phoneNumber: company?.phoneNumber ?? '',
        )
        .execute();
  }

  @override
  Future<List<Company>> fetchCompanies() async {
    final result = await _getAllCompaniesQuery.execute();
    final data = result.data.companies;

    return data.map((company) => Company.fromJson(company.toJson())).toList();
  }

  @override
  Stream<List<Company>> watchCompanies() {
    return _getAllCompaniesQuery.subscribe().map((result) {
      // Handle real-time updates here
      final data = result.data.companies;
      final companies = data
          .map((company) => Company.fromJson(company.toJson()))
          .toList();
      return companies;
    });
  }
}
