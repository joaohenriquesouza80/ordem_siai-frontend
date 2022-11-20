import 'package:flutter/material.dart';
import 'package:ordem_siai/src/shared/providers/app_info/app_info_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/routes/app_routes_names.dart';
import '../../auth/providers/auth_provider.dart';

class HomePageController {
  final BuildContext _context;

  HomePageController(this._context);

  String _appVersion = '';

  String get appVersion => _appVersion;

  TextEditingController searchController = TextEditingController();

  Future<void> startProcess() async {
    print('startProcess()...');
  }

  void openFilter() {
    Scaffold.of(_context).openEndDrawer();
  }

  loadAppVersion() async {
    final appInfo = Provider.of<AppInfoProvider>(
      _context,
      listen: false,
    );

    _appVersion = await appInfo.getAppVersion();
  }

  logout() async {
    final authProvider = Provider.of<AuthProvider>(
      _context,
      listen: false,
    );
    await authProvider.logout();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(
      _context,
      AppRoutesNames.AUTH_HOME,
    );
  }
}
