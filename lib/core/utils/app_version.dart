import 'package:package_info_plus/package_info_plus.dart';

class AppInfo {
  static String version = "";
  static String buildNumber = "";

  static Future<void> init() async {
    final info = await PackageInfo.fromPlatform();
    version = info.version;
    buildNumber = info.buildNumber;
  }
}
