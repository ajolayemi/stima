import 'package:stima/core/utils/app_utils.dart';
import 'package:stima/dataconnect_generated/generated.dart';

class FirebaseDataConnectService {
  const FirebaseDataConnectService._();

  static StimaDataConnector get stimaDataConnector {
    return StimaDataConnector.instance;
  }

  static void startLocalEmulators() {
    stimaDataConnector.dataConnect.useDataConnectEmulator(
      AppUtils.firebaseLocalHost,
      9399,
    );
  }
}
