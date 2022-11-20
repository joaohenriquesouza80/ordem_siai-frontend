import 'package:flutter/material.dart';
import 'package:ordem_siai/src/shared/providers/app_info/app_info_provider.dart';
import 'package:provider/provider.dart';

import '../../../shared/routes/app_routes_names.dart';
import '../../auth/providers/auth_provider.dart';
import '../../user_profile/models/user_profile_model.dart';
import '../../user_profile/providers/user_profile_provider.dart';

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

  Future<void> loadProfile() async {
    try {
      final userProfileProvider = Provider.of<UserProfileProvider>(
        _context,
        listen: false,
      );
      if (!userProfileProvider.loaded) {
        await userProfileProvider.loadProfile();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  UserProfileModel getUserProfile() {
    final userProfileProvider = Provider.of<UserProfileProvider>(
      _context,
      listen: false,
    );
    return userProfileProvider.profile;
  }

  String getUserName() {
    final userProfileProvider = Provider.of<UserProfileProvider>(
      _context,
      listen: false,
    );

    if (userProfileProvider.profile.name != null &&
        userProfileProvider.profile.name!.isNotEmpty) {
      return userProfileProvider.profile.name!;
    }

    final authProvider = Provider.of<AuthProvider>(
      _context,
      listen: false,
    );
    return authProvider.authUser!.user.email!.split('@').first;
  }

  goToUsersPage(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.pushNamed(
      context,
      AppRoutesNames.USERS,
    );
  }
}
