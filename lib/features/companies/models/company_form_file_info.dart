import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_form_file_info.freezed.dart';

@freezed
abstract class CompanyFormFileInfo with _$CompanyFormFileInfo {
  CompanyFormFileInfo._({
    int? productionAreasFound,
    String? fileName,
    String? fileSizeString,
    int? accessAreasFound,
    this.file,
    this.kmlMapFileLink
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
    String? kmlMapFileLink,
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

  @override
  /// A link that will be used to access the KML file directly from google maps
  final String? kmlMapFileLink;

  bool get isValid {
    return fileName.isNotEmpty;
  }
}
