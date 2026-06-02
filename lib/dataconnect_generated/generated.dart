library dataconnect_generated;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';

part 'create_company.dart';

part 'update_company.dart';

part 'delete_company.dart';

part 'get_all_companies.dart';







class StimaDataConnector {
  
  
  CreateCompanyVariablesBuilder createCompany ({required String name, required String contactPersonName, required String phoneNumber, }) {
    return CreateCompanyVariablesBuilder(dataConnect, name: name,contactPersonName: contactPersonName,phoneNumber: phoneNumber,);
  }
  
  
  UpdateCompanyVariablesBuilder updateCompany ({required String id, }) {
    return UpdateCompanyVariablesBuilder(dataConnect, id: id,);
  }
  
  
  DeleteCompanyVariablesBuilder deleteCompany ({required String id, }) {
    return DeleteCompanyVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetAllCompaniesVariablesBuilder getAllCompanies () {
    return GetAllCompaniesVariablesBuilder(dataConnect, );
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'europe-west8',
    'StimaData',
    'stime-dev-473921-service',
  );

  StimaDataConnector({required this.dataConnect});
  static StimaDataConnector get instance {
    
    return StimaDataConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
