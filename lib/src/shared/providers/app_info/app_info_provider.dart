import 'package:flutter/material.dart';

import 'implementations/app_info_packageinfoplus.dart';

abstract class AppInfoProvider with ChangeNotifier {
  Future<String> getAppVersion();

  factory AppInfoProvider() {
    return AppInfoPackageInfoPlus();
  }
}
