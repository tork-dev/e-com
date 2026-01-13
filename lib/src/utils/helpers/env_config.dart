import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Read from dart-define for web/mobile
const String baseUrlFromDefine = String.fromEnvironment('BASE_URL');
const String baseUrlWebFromDefine = String.fromEnvironment('BASE_URL_WEB');
const String androidAppLinkFromDefine = String.fromEnvironment('ANDROID_APP_LINK');
const String iosAppLinkFromDefine = String.fromEnvironment('IOS_APP_LINK');


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
      return dotenv.env['BASE_URL'] ?? 'https://frontendapi.kireibd.com/api/v2';
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
    return dotenv.env['ANDROID_APP_LINK'] ?? 'https://play.google.com/store/apps/details?id=com.thetork.kirei';
  }

  /// iOS app link
  static String get iosAppLink {
    return dotenv.env['IOS_APP_LINK'] ?? 'https://apps.apple.com/hu/app/kirei/id6502335026';
  }
}
