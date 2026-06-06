import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:logging/logging.dart';
import 'package:stima/core/constants/app_constants.dart';
import 'package:stima/core/dto/firebase_callable_func_data.dart';
import 'package:stima/features/companies/constants/company_firestore_constants.dart';
import 'package:stima/features/companies/data/company_repository.dart';
import 'package:stima/features/companies/models/company.dart';

class FirestoreCompanyRepository implements CompanyRepository {
  final FirebaseFirestore _firestore;
  final FirebaseFunctions _functions;

  FirestoreCompanyRepository(this._firestore, this._functions);

  static final _logger = Logger('FirestoreCompanyRepository');

  CollectionReference<Company> get _companiesDocRef {
    return _firestore
        .collection(CompanyFirestoreConstants.companiesCollection)
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

    final payloadData = FirebaseCallableFuncData(
      collectionName: CompanyFirestoreConstants.companiesCollection,
      data: company.toJson(),
    );

    final result = await _functions
        .httpsCallable(AppConstants.addDocumentFirebaseFunc)
        .call(payloadData.toJson());
    final resultData = result.data;

    if (resultData is Map<String, dynamic>) {
      final docId = resultData['document_id'];
      _logger.info('company created with document id: $docId');
    }
  }

  @override
  Future<List<Company>> fetchCompanies() async {
    final snapshot = await _companiesDocRef.get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Stream<List<Company>> watchCompanies() {
    return _companiesDocRef.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Future<Company?> getCompany(String companyId) async {
    final doc = await _companiesDocRef.doc(companyId).get();
    return doc.data();
  }
}
