import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'package:stima/features/companies/data/company_repository.dart';
import 'package:stima/features/companies/models/company.dart';

class FirestoreCompanyRepository implements CompanyRepository {
  final FirebaseFirestore _firestore;

  FirestoreCompanyRepository(this._firestore);

  static final _logger = Logger('FirestoreCompanyRepository');

  CollectionReference<Company> get _companiesDocRef {
    return _firestore
        .collection('companies')
        .withConverter<Company>(
          fromFirestore: (snapshot, _) {
            return Company.fromJson(snapshot.data() ?? <String, dynamic>{});
          },
          toFirestore: (model, _) {
            return model.toJson();
          },
        );
  }

  @override
  Future<void> addCompany(Company? company) async {
    if (company == null) {
      _logger.warning('Attempted to add a null company');
      return;
    }

    try {
      await _companiesDocRef.doc(company.name).set(company);
      _logger.info('Company with name ${company.name} added successfully');
    } catch (e, st) {
      _logger.severe('Failed to add company: $e', e, st);
      rethrow;
    }
  }

  @override
  Future<List<Company>> fetchCompanies() async {
    final snapshot = await _companiesDocRef.get();
    _logger.fine('Fetched companies: ${snapshot.docs}');
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Stream<List<Company>> watchCompanies() {
    return _companiesDocRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    }); 
  }
}
