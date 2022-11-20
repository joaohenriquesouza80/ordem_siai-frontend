import 'package:flutter/foundation.dart';
import 'package:ordem_siai/src/shared/providers/app_info/app_info_provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoPackageInfoPlus with ChangeNotifier implements AppInfoProvider {
  @override
  Future<String> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String code = packageInfo.buildNumber;

    //notifyListeners();

    return '$version+$code';
  }
}
