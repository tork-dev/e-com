import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Read from dart-define for web/mobile
const String baseUrlFromDefine = String.fromEnvironment('BASEURL');
const String baseUrlWebFromDefine = String.fromEnvironment('BASEURLWEB');
const String androidAppLinkFromDefine = String.fromEnvironment('ANDROIDAPPLINK');
const String iosAppLinkFromDefine = String.fromEnvironment('IOSAPPLINK');


class EnvConfig {
  EnvConfig._();

  /// API base URL
  static String get baseUrl {
    if (kIsWeb) {
      // Web build uses dart-define first
      return baseUrlFromDefine.isNotEmpty
          ? baseUrlFromDefine
          : 'https://frontendapi.kireibd.com/api/v2';
    } else {
      // Mobile uses dotenv
      return dotenv.env['BASEURL'] ?? 'https://frontendapi.kireibd.com/api/v2';
    }
  }

  /// Web frontend URL
  static String get baseUrlWeb {
    if (kIsWeb) {
      return baseUrlWebFromDefine.isNotEmpty
          ? baseUrlWebFromDefine
          : 'https://kireibd.com';
    } else {
      return dotenv.env['BASE_URL_WEB'] ?? 'https://kireibd.com';
    }
  }

  /// Android app link
  static String get androidAppLink {
    return dotenv.env['ANDROIDAPPLINK'] ?? 'https://play.google.com/store/apps/details?id=com.thetork.kirei';
  }

  /// iOS app link
  static String get iosAppLink {
    return dotenv.env['IOSAPPLINK'] ?? 'https://apps.apple.com/hu/app/kirei/id6502335026';
  }
}
