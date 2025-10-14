import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/enums/app_file_type.dart';
import 'package:stima/core/utils/file_utils.dart';
import 'package:stima/features/companies/enums/kml_folder_type.dart';
import 'package:stima/features/companies/models/company_form_data.dart';
import 'package:stima/features/companies/providers/company_form_providers.dart';
import 'package:stima/features/companies/utils/xml_file_parser_utils.dart';

part 'company_service.g.dart';

class CompanyService {
  final Ref _ref;

  const CompanyService(this._ref);

  Future<File?> pickCompanyKmlFile() async {
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: AppFileType.kml.extensions,
    );

    debugPrint('Picker result: $pickerResult');

    final pickedFiles = pickerResult?.files;

    if (pickedFiles == null || pickedFiles.isEmpty) {
      return Future.value(null);
    }

    final pickedFile = pickedFiles.first;
    final pickedFilePath = pickedFile.path;

    if (pickedFilePath == null || pickedFilePath.isEmpty) {
      return Future.value(null);
    }

    final file = File(pickedFilePath);

    final dataFromKmlFile = await XmlFileParserUtils.processCompanyKml(file);
    final prodAreas =
        dataFromKmlFile?[KmlFolderType.production.folderName] ?? [];
    final accessAreas = dataFromKmlFile?[KmlFolderType.access.folderName] ?? [];

    final fileData = CompanyFormFileInfo.data(
      file: file,
      fileName: pickedFile.name,
      accessAreasFound: accessAreas.length,
      productionAreasFound: prodAreas.length,
      fileSizeString: FileUtils.getFileSizeString(pickedFile.size),
    );

    _ref.read(companyFormDataProvider.notifier).updateFileInfo(fileData);

    // TODO: return the complete data here

    // TODO: track value using notifier class

    return file;
  }
}

@Riverpod(keepAlive: true)
CompanyService companyService(Ref ref) {
  return CompanyService(ref);
}
