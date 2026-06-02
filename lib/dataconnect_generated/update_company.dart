part of 'generated.dart';

class UpdateCompanyVariablesBuilder {
  String id;
  Optional<String> _name = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _contactPersonName = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _phoneNumber = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _email = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _address = Optional.optional(nativeFromJson, nativeToJson);
  Optional<bool> _isActive = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _kmlMapFileLink = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  UpdateCompanyVariablesBuilder name(String? t) {
   _name.value = t;
   return this;
  }
  UpdateCompanyVariablesBuilder contactPersonName(String? t) {
   _contactPersonName.value = t;
   return this;
  }
  UpdateCompanyVariablesBuilder phoneNumber(String? t) {
   _phoneNumber.value = t;
   return this;
  }
  UpdateCompanyVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  UpdateCompanyVariablesBuilder address(String? t) {
   _address.value = t;
   return this;
  }
  UpdateCompanyVariablesBuilder isActive(bool? t) {
   _isActive.value = t;
   return this;
  }
  UpdateCompanyVariablesBuilder kmlMapFileLink(String? t) {
   _kmlMapFileLink.value = t;
   return this;
  }

  UpdateCompanyVariablesBuilder(this._dataConnect, {required  this.id,});
  Deserializer<UpdateCompanyData> dataDeserializer = (dynamic json)  => UpdateCompanyData.fromJson(jsonDecode(json));
  Serializer<UpdateCompanyVariables> varsSerializer = (UpdateCompanyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateCompanyData, UpdateCompanyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<UpdateCompanyData, UpdateCompanyVariables> ref() {
    UpdateCompanyVariables vars= UpdateCompanyVariables(id: id,name: _name,contactPersonName: _contactPersonName,phoneNumber: _phoneNumber,email: _email,address: _address,isActive: _isActive,kmlMapFileLink: _kmlMapFileLink,);
    return _dataConnect.mutation("UpdateCompany", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class UpdateCompanyCompanyUpdate {
  final String id;
  UpdateCompanyCompanyUpdate.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateCompanyCompanyUpdate otherTyped = other as UpdateCompanyCompanyUpdate;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  UpdateCompanyCompanyUpdate({
    required this.id,
  });
}

@immutable
class UpdateCompanyData {
  final UpdateCompanyCompanyUpdate? company_update;
  UpdateCompanyData.fromJson(dynamic json):
  
  company_update = json['company_update'] == null ? null : UpdateCompanyCompanyUpdate.fromJson(json['company_update']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateCompanyData otherTyped = other as UpdateCompanyData;
    return company_update == otherTyped.company_update;
    
  }
  @override
  int get hashCode => company_update.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (company_update != null) {
      json['company_update'] = company_update!.toJson();
    }
    return json;
  }

  UpdateCompanyData({
    this.company_update,
  });
}

@immutable
class UpdateCompanyVariables {
  final String id;
  late final Optional<String>name;
  late final Optional<String>contactPersonName;
  late final Optional<String>phoneNumber;
  late final Optional<String>email;
  late final Optional<String>address;
  late final Optional<bool>isActive;
  late final Optional<String>kmlMapFileLink;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  UpdateCompanyVariables.fromJson(Map<String, dynamic> json):
  
  id = nativeFromJson<String>(json['id']) {
  
  
  
    name = Optional.optional(nativeFromJson, nativeToJson);
    name.value = json['name'] == null ? null : nativeFromJson<String>(json['name']);
  
  
    contactPersonName = Optional.optional(nativeFromJson, nativeToJson);
    contactPersonName.value = json['contactPersonName'] == null ? null : nativeFromJson<String>(json['contactPersonName']);
  
  
    phoneNumber = Optional.optional(nativeFromJson, nativeToJson);
    phoneNumber.value = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']);
  
  
    email = Optional.optional(nativeFromJson, nativeToJson);
    email.value = json['email'] == null ? null : nativeFromJson<String>(json['email']);
  
  
    address = Optional.optional(nativeFromJson, nativeToJson);
    address.value = json['address'] == null ? null : nativeFromJson<String>(json['address']);
  
  
    isActive = Optional.optional(nativeFromJson, nativeToJson);
    isActive.value = json['isActive'] == null ? null : nativeFromJson<bool>(json['isActive']);
  
  
    kmlMapFileLink = Optional.optional(nativeFromJson, nativeToJson);
    kmlMapFileLink.value = json['kmlMapFileLink'] == null ? null : nativeFromJson<String>(json['kmlMapFileLink']);
  
  }
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final UpdateCompanyVariables otherTyped = other as UpdateCompanyVariables;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    contactPersonName == otherTyped.contactPersonName && 
    phoneNumber == otherTyped.phoneNumber && 
    email == otherTyped.email && 
    address == otherTyped.address && 
    isActive == otherTyped.isActive && 
    kmlMapFileLink == otherTyped.kmlMapFileLink;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, contactPersonName.hashCode, phoneNumber.hashCode, email.hashCode, address.hashCode, isActive.hashCode, kmlMapFileLink.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    if(name.state == OptionalState.set) {
      json['name'] = name.toJson();
    }
    if(contactPersonName.state == OptionalState.set) {
      json['contactPersonName'] = contactPersonName.toJson();
    }
    if(phoneNumber.state == OptionalState.set) {
      json['phoneNumber'] = phoneNumber.toJson();
    }
    if(email.state == OptionalState.set) {
      json['email'] = email.toJson();
    }
    if(address.state == OptionalState.set) {
      json['address'] = address.toJson();
    }
    if(isActive.state == OptionalState.set) {
      json['isActive'] = isActive.toJson();
    }
    if(kmlMapFileLink.state == OptionalState.set) {
      json['kmlMapFileLink'] = kmlMapFileLink.toJson();
    }
    return json;
  }

  UpdateCompanyVariables({
    required this.id,
    required this.name,
    required this.contactPersonName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.isActive,
    required this.kmlMapFileLink,
  });
}

