import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static void launchUrlUtil(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      debugPrint('UrlLauncherUtils: launching url - $url');
      launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
