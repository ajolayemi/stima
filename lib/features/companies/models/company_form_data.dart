// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_form_data.freezed.dart';

@freezed
abstract class CompanyFormData with _$CompanyFormData {
  const CompanyFormData._();

  const factory CompanyFormData({CompanyFormFileInfo? fileInfo}) =
      _CompanyFormData;
}

@freezed
abstract class CompanyFormFileInfo with _$CompanyFormFileInfo {
  CompanyFormFileInfo._({
    int? productionAreasFound,
    String? fileName,
    String? fileSizeString,
    int? accessAreasFound,
    this.file,
  }) : productionAreasFound = productionAreasFound ?? 0,
       fileName = fileName ?? '',
       fileSizeString = fileSizeString ?? '',
       accessAreasFound = accessAreasFound ?? 0;

  factory CompanyFormFileInfo.data({
    int? productionAreasFound,
    String? fileName,
    String? fileSizeString,
    int? accessAreasFound,
    File? file,
  }) = CompanyFormFileInfoData;

  @override
  final int productionAreasFound;

  @override
  final int accessAreasFound;

  @override
  final String fileName;

  @override
  final String? fileSizeString;

  @override
  final File? file;

  bool get isValid {
    return fileName.isNotEmpty;
  }
}
