import 'package:logging/logging.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static final _logger = Logger('UrlLauncherUtils');
  static Future<void> launchUrlUtil(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      _logger.warning('Error launching url - $url', e);
    }
  }

  static Future<void> launchTelUtil(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      _logger.warning('Phone number is null or empty');
      return;
    }
    final telUrl = 'tel:$phoneNumber';
    await launchUrlUtil(telUrl);
  }
}
