import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/users/providers/users_provider.dart';
import 'package:ordem_siai/src/shared/providers/client_http/client_http_no_auth_provider.dart';
import 'package:provider/provider.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/user_profile/providers/user_profile_provider.dart';
import 'app_info/app_info_provider.dart';
import 'client_http/client_http_provider.dart';
import 'local_storage/local_storage_provider.dart';
import 'time_zone/timezone_provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => TimeZoneProvider(),
        ),
        Provider(
          create: (_) => LocalStorageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppInfoProvider(),
        ),
        Provider(
          create: (context) => ClientHttpNoAuthProvider(context),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthProvider(context.read(), context.read()),
        ),
        Provider(
          create: (context) => ClientHttpProvider(context.read(), context),
        ),
        ChangeNotifierProvider(
          create: (context) =>
              UserProfileProvider(context.read(), context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => UsersProvider(context.read()),
        ),
      ],
      child: child,
    );
  }
}
