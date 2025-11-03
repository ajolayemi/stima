import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:stima/core/enums/app_file_type.dart';
import 'package:stima/core/exceptions/app_exception.dart';
import 'package:stima/core/network/network_requests.dart';
import 'package:stima/core/utils/file_utils.dart';
import 'package:stima/features/companies/data/company_repository.dart';
import 'package:stima/features/companies/enums/kml_folder_type.dart';
import 'package:stima/features/companies/models/company.dart';
import 'package:stima/features/companies/models/company_form_file_info.dart';
import 'package:stima/features/companies/providers/company_form_providers.dart';
import 'package:stima/features/companies/providers/company_repo_providers.dart';
import 'package:stima/features/companies/utils/xml_file_parser_utils.dart';

part 'company_service.g.dart';

class CompanyService {
  final Ref _ref;

  const CompanyService(this._ref);

  static final _logger = Logger('CompanyService');

  CompanyRepository get _companyRepo {
    return _ref.read(companyRepositoryProvider);
  }

  Future<void> addCompany() async {
    final companyFormData = _ref.read(companyFormDataProvider);

    if (companyFormData == null) {
      return;
    }
    final company = Company.fromForm(companyFormData);
    await _companyRepo.addCompany(company);
  }

  /// Opens file picker to select a KML file for the company.
  /// Parses the file to extract production and access areas.
  /// Updates the CompanyFormDataProvider with the file info.
  /// Returns the selected File, or null if no file was picked.
  Future<File?> pickCompanyKmlFile() async {
    _ref.read(companyFormDataProvider.notifier).resetFileInfo();
    final pickerResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: AppFileType.kml.extensions,
    );

    _logger.info('Picker result: $pickerResult');

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

    final link = await XmlFileParserUtils.processCompanyKmlWithLink(file);

    if (link == null) {
      throw InvalidKmlFileException(stackTrace: StackTrace.current);
    }

    final tempDir = await getTemporaryDirectory();

    final downloadedFile = await NetworkRequests().downloadFile(
      link,
      tempDir: tempDir.path,
      fileName: pickedFile.name,
    );

    final dataFromKmlFile = await XmlFileParserUtils.processCompanyKml(
      downloadedFile,
    );
    final prodAreas =
        dataFromKmlFile?[KmlFolderType.production.folderName] ?? [];
    final accessAreas = dataFromKmlFile?[KmlFolderType.access.folderName] ?? [];

    final fileData = CompanyFormFileInfo.data(
      file: file,
      fileName: pickedFile.name,
      accessAreasFound: accessAreas.length,
      productionAreasFound: prodAreas.length,
      fileSizeString: FileUtils.getFileSizeString(pickedFile.size),
      kmlMapFileLink: link,
    );

    _ref.read(companyFormDataProvider.notifier).updateFileInfo(fileData);

    return file;
  }
}

@Riverpod(keepAlive: true)
CompanyService companyService(Ref ref) {
  return CompanyService(ref);
}
