part of 'generated.dart';

class GetAllCompaniesVariablesBuilder {
  
  final FirebaseDataConnect _dataConnect;
  GetAllCompaniesVariablesBuilder(this._dataConnect, );
  Deserializer<GetAllCompaniesData> dataDeserializer = (dynamic json)  => GetAllCompaniesData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetAllCompaniesData, void>> execute() {
    return ref().execute();
  }

  QueryRef<GetAllCompaniesData, void> ref() {
    
    return _dataConnect.query("GetAllCompanies", dataDeserializer, emptySerializer, null);
  }
}

@immutable
class GetAllCompaniesCompanies {
  final String id;
  final String name;
  final String contactPersonName;
  final String? phoneNumber;
  final String? email;
  final String? address;
  final bool isActive;
  final String? kmlMapFileLink;
  final Timestamp createdAt;
  final Timestamp? updatedAt;
  GetAllCompaniesCompanies.fromJson(dynamic json):
  
  id = nativeFromJson<String>(json['id']),
  name = nativeFromJson<String>(json['name']),
  contactPersonName = nativeFromJson<String>(json['contactPersonName']),
  phoneNumber = json['phoneNumber'] == null ? null : nativeFromJson<String>(json['phoneNumber']),
  email = json['email'] == null ? null : nativeFromJson<String>(json['email']),
  address = json['address'] == null ? null : nativeFromJson<String>(json['address']),
  isActive = nativeFromJson<bool>(json['isActive']),
  kmlMapFileLink = json['kmlMapFileLink'] == null ? null : nativeFromJson<String>(json['kmlMapFileLink']),
  createdAt = Timestamp.fromJson(json['createdAt']),
  updatedAt = json['updatedAt'] == null ? null : Timestamp.fromJson(json['updatedAt']);
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllCompaniesCompanies otherTyped = other as GetAllCompaniesCompanies;
    return id == otherTyped.id && 
    name == otherTyped.name && 
    contactPersonName == otherTyped.contactPersonName && 
    phoneNumber == otherTyped.phoneNumber && 
    email == otherTyped.email && 
    address == otherTyped.address && 
    isActive == otherTyped.isActive && 
    kmlMapFileLink == otherTyped.kmlMapFileLink && 
    createdAt == otherTyped.createdAt && 
    updatedAt == otherTyped.updatedAt;
    
  }
  @override
  int get hashCode => Object.hashAll([id.hashCode, name.hashCode, contactPersonName.hashCode, phoneNumber.hashCode, email.hashCode, address.hashCode, isActive.hashCode, kmlMapFileLink.hashCode, createdAt.hashCode, updatedAt.hashCode]);
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = nativeToJson<String>(id);
    json['name'] = nativeToJson<String>(name);
    json['contactPersonName'] = nativeToJson<String>(contactPersonName);
    if (phoneNumber != null) {
      json['phoneNumber'] = nativeToJson<String?>(phoneNumber);
    }
    if (email != null) {
      json['email'] = nativeToJson<String?>(email);
    }
    if (address != null) {
      json['address'] = nativeToJson<String?>(address);
    }
    json['isActive'] = nativeToJson<bool>(isActive);
    if (kmlMapFileLink != null) {
      json['kmlMapFileLink'] = nativeToJson<String?>(kmlMapFileLink);
    }
    json['createdAt'] = createdAt.toJson();
    if (updatedAt != null) {
      json['updatedAt'] = updatedAt!.toJson();
    }
    return json;
  }

  GetAllCompaniesCompanies({
    required this.id,
    required this.name,
    required this.contactPersonName,
    this.phoneNumber,
    this.email,
    this.address,
    required this.isActive,
    this.kmlMapFileLink,
    required this.createdAt,
    this.updatedAt,
  });
}

@immutable
class GetAllCompaniesData {
  final List<GetAllCompaniesCompanies> companies;
  GetAllCompaniesData.fromJson(dynamic json):
  
  companies = (json['companies'] as List<dynamic>)
        .map((e) => GetAllCompaniesCompanies.fromJson(e))
        .toList();
  @override
  bool operator ==(Object other) {
    if(identical(this, other)) {
      return true;
    }
    if(other.runtimeType != runtimeType) {
      return false;
    }

    final GetAllCompaniesData otherTyped = other as GetAllCompaniesData;
    return companies == otherTyped.companies;
    
  }
  @override
  int get hashCode => companies.hashCode;
  

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['companies'] = companies.map((e) => e.toJson()).toList();
    return json;
  }

  GetAllCompaniesData({
    required this.companies,
  });
}

