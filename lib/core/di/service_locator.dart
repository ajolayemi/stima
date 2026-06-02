import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:stima/core/exceptions/error_logger.dart';
import 'package:stima/features/companies/data/company_repository.dart';
import 'package:stima/features/companies/data/dataconnect_company_repository.dart';

class ServiceLocator {
  const ServiceLocator._();

  static final _logger = Logger('ServiceLocator');

  static GetIt get _getIt => GetIt.instance;


  static void init() {
    _logger.info('Initializing ServiceLocator');
    _registerRepositories();
    _registerMiscellaneous();
  }

  static void _registerRepositories() {
    _logger.info('Registering repositories');
    _getIt.registerSingleton<CompanyRepository>(
      DataConnectCompanyRepository(),
    );
  }

  static void _registerMiscellaneous() {
    _logger.info('Registering miscellaneous services');
    _getIt.registerSingleton<ErrorLogger>(FirebaseErrorLogger());
  }

  static T get<T extends Object>() {
    _logger.fine('Retrieving service of type $T');
    return _getIt.get<T>();
  }

  static T? getNullable<T extends Object>() {
    _logger.fine('Maybe retrieving service of type $T');
    return _getIt.maybeGet<T>();
  }
}
