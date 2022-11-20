import 'implementations/app_info_packageinfoplus.dart';

abstract class AppInfoProvider {
  Future<String> getAppVersion();

  factory AppInfoProvider() {
    return AppInfoPackageInfoPlus();
  }
}
