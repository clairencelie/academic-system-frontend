import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class PlatformTypeDetector {
  static String platformName = 'Android';

  static void detect() {
    if (kIsWeb) {
      platformName = 'Web';
    } else {
      if (Platform.isAndroid) {
        platformName = 'Android';
      } else if (Platform.isIOS) {
        platformName = 'IOS';
      } else if (Platform.isFuchsia) {
        platformName = 'Fuchsia';
      } else if (Platform.isLinux) {
        platformName = 'Linux';
      } else if (Platform.isMacOS) {
        platformName = 'MacOS';
      } else if (Platform.isWindows) {
        platformName = 'Windows';
      }
    }
  }
}
