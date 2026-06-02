part of 'generated.dart';

class DeleteCompanyVariablesBuilder {
  String id;

  final FirebaseDataConnect _dataConnect;
  DeleteCompanyVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<DeleteCompanyData> dataDeserializer = (dynamic json)  => DeleteCompanyData.fromJson(jsonDecode(json));
  Serializer<DeleteCompanyVariables> varsSerializer = (DeleteCompanyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteCompanyData, DeleteCompanyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<DeleteCompanyData, DeleteCompanyVariables> ref() {
    DeleteCompanyVariables vars= DeleteCompanyVariables(id: id,);
    return _dataConnect.mutation("DeleteCompany", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class DeleteCompanyCompanyDelete {
  final String id;
  DeleteCompanyCompanyDelete.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCompanyCompanyDelete otherTyped = other as DeleteCompanyCompanyDelete;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteCompanyCompanyDelete({
    required this.id,
  });
}

@immutable
class DeleteCompanyData {
  final DeleteCompanyCompanyDelete? company_delete;
  DeleteCompanyData.fromJson(dynamic json):
  
  company_delete = json['company_delete'] == null ? null : DeleteCompanyCompanyDelete.fromJson(json['company_delete']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCompanyData otherTyped = other as DeleteCompanyData;
    return company_delete == otherTyped.company_delete;
    
  }
  @override
  int get hashCode => company_delete.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (company_delete != null) {
      json['company_delete'] = company_delete!.toJson();
    }
    return json;
  }

  DeleteCompanyData({
    this.company_delete,
  });
}

@immutable
class DeleteCompanyVariables {
  final String id;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  DeleteCompanyVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final DeleteCompanyVariables otherTyped = other as DeleteCompanyVariables;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  DeleteCompanyVariables({
    required this.id,
  });
}

