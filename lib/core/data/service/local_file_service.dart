import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:stima/core/utils/app_utils.dart';

class LocalFileService {
  const LocalFileService._();

  static final _logger = Logger('LocalFileService');

  static Future<Map<String, dynamic>> getRemoteConfigDefault() async {
    try {
      final currentFlavor = AppUtils.appCurrentFlavor;

      if (currentFlavor == null) {
        return {};
      }
      final fileContent = await rootBundle.loadString(
        'assets/config/remote_config_defaults_${currentFlavor.name}.json',
      );
      final decodedData = jsonDecode(fileContent);
      return decodedData;
    } catch (e, st) {
      _logger.severe(
        'an error occurred while fetching countries from local asset, $e, $st',
        e,
        st,
      );
      return {};
    }
  }
}
