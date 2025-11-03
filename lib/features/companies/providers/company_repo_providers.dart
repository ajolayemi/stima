import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/providers/firebase_providers.dart';
import 'package:stima/features/companies/data/company_repository.dart';
import 'package:stima/features/companies/data/firebase_company_repository.dart';

part 'company_repo_providers.g.dart';

@Riverpod(keepAlive: true)
CompanyRepository companyRepository(Ref ref) {
  final firestore = ref.read(firebaseFirestoreProvider);
  return FirestoreCompanyRepository(firestore);
}
