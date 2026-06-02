part of 'generated.dart';

class CreateCompanyVariablesBuilder {
  String name;
  String contactPersonName;
  String phoneNumber;
  Optional<String> _email = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _address = Optional.optional(nativeFromJson, nativeToJson);
  Optional<bool> _isActive = Optional.optional(nativeFromJson, nativeToJson);
  Optional<String> _kmlMapFileLink = Optional.optional(nativeFromJson, nativeToJson);

  final FirebaseDataConnect _dataConnect;  CreateCompanyVariablesBuilder email(String? t) {
   _email.value = t;
   return this;
  }
  CreateCompanyVariablesBuilder address(String? t) {
   _address.value = t;
   return this;
  }
  CreateCompanyVariablesBuilder isActive(bool? t) {
   _isActive.value = t;
   return this;
  }
  CreateCompanyVariablesBuilder kmlMapFileLink(String? t) {
   _kmlMapFileLink.value = t;
   return this;
  }

  CreateCompanyVariablesBuilder(this._dataConnect, {required  this.name,required  this.contactPersonName,required  this.phoneNumber,});
  Deserializer<CreateCompanyData> dataDeserializer = (dynamic json)  => CreateCompanyData.fromJson(jsonDecode(json));
  Serializer<CreateCompanyVariables> varsSerializer = (CreateCompanyVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<CreateCompanyData, CreateCompanyVariables>> execute() {
    return ref().execute();
  }

  MutationRef<CreateCompanyData, CreateCompanyVariables> ref() {
    CreateCompanyVariables vars= CreateCompanyVariables(name: name,contactPersonName: contactPersonName,phoneNumber: phoneNumber,email: _email,address: _address,isActive: _isActive,kmlMapFileLink: _kmlMapFileLink,);
    return _dataConnect.mutation("CreateCompany", dataDeserializer, varsSerializer, vars);
  }
}

@immutable
class CreateCompanyCompanyInsert {
  final String id;
  CreateCompanyCompanyInsert.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCompanyCompanyInsert otherTyped = other as CreateCompanyCompanyInsert;
    return id == otherTyped.id;
    
  }
  @override
  int get hashCode => id.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    return json;
  }

  CreateCompanyCompanyInsert({
    required this.id,
  });
}

@immutable
class CreateCompanyData {
  final CreateCompanyCompanyInsert company_insert;
  CreateCompanyData.fromJson(dynamic json):
  
  company_insert = CreateCompanyCompanyInsert.fromJson(json['company_insert']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final CreateCompanyData otherTyped = other as CreateCompanyData;
    return company_insert == otherTyped.company_insert;
    
  }
  @override
  int get hashCode => company_insert.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['company_insert'] = company_insert.toJson();
    return json;
  }

  CreateCompanyData({
    required this.company_insert,
  });
}

@immutable
class CreateCompanyVariables {
  final String name;
  final String contactPersonName;
  final String phoneNumber;
  late final Optional<String>email;
  late final Optional<String>address;
  late final Optional<bool>isActive;
  late final Optional<String>kmlMapFileLink;
  @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
  CreateCompanyVariables.fromJson(Map<String, dynamic> json):
  
  name = nativeFromJson<String>(json['name']),
  contactPersonName = nativeFromJson<String>(json['contactPersonName']),
  phoneNumber = nativeFromJson<String>(json['phoneNumber']) {
  
  
  
  
  
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

    final CreateCompanyVariables otherTyped = other as CreateCompanyVariables;
    return name == otherTyped.name && 
    contactPersonName == otherTyped.contactPersonName && 
    phoneNumber == otherTyped.phoneNumber && 
    email == otherTyped.email && 
    address == otherTyped.address && 
    isActive == otherTyped.isActive && 
    kmlMapFileLink == otherTyped.kmlMapFileLink;
    
  }
  @override
  int get hashCode => Object.hashAll([name.hashCode, contactPersonName.hashCode, phoneNumber.hashCode, email.hashCode, address.hashCode, isActive.hashCode, kmlMapFileLink.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['name'] = nativeToJson<String>(name);
    json['contactPersonName'] = nativeToJson<String>(contactPersonName);
    json['phoneNumber'] = nativeToJson<String>(phoneNumber);
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

  CreateCompanyVariables({
    required this.name,
    required this.contactPersonName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.isActive,
    required this.kmlMapFileLink,
  });
}

