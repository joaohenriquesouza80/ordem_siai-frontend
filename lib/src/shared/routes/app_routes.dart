import 'package:flutter/material.dart';
import 'package:ordem_siai/src/features/packages/detail_package_page.dart';
import 'package:ordem_siai/src/features/packages/packages_page.dart';

import '../../features/auth/auth_home_page.dart';
import '../../features/home/home_page.dart';
import '../../features/packages/insert_package_page.dart';
import '../../features/splash/splash_page.dart';
import 'app_routes_names.dart';

class AppRoutes {
  Object? _args;

  get initialRoute => AppRoutesNames.AUTH_HOME;

  getRoutes(BuildContext context, String? queryParam) {
    return {
      //'/': (context) => AuthOrHomePage(),
      '/': (context) => PackagesPage(
            pageController: null,
            queryParam: queryParam,
          ),
      '/packages/insert': (context) => const InsertPackagePage(
            pageController: null,
          ),
      '/packages/detail': (context) => const DetailPackagePage(
            pageController: null,
          ),
    };
  }

  Route? doGenerateRoutes(RouteSettings settings) {
    _args = settings.arguments;

    switch (settings.name) {
      case AppRoutesNames.AUTH_HOME:
        return _createRouteT(widgetPage: AuthOrHomePage(), duration: 3);
      case AppRoutesNames.HOME:
        return _createRouteT(widgetPage: const HomePage(), duration: 5);
      case AppRoutesNames.USERS:
        return _createRouteT(widgetPage: const SplashPage());
      //case AppRoutesNames.PACKAGES:
      //  return _createRouteT(widgetPage: const PackagesPage());
      //case AppRoutesNames.INSERT_PACKAGE:
      //  return _createRouteT(widgetPage: const InsertPackagePage());
      default:
        return _createRouteT(widgetPage: AuthOrHomePage(), duration: 3);
    }
  }

  Route _createRouteT({required Widget widgetPage, int duration = 500}) {
    return PageRouteBuilder(
      transitionDuration: Duration(seconds: duration),
      pageBuilder: (_, __, ___) => widgetPage,
      settings: RouteSettings(arguments: _args),
      maintainState: false,
    );
  }

  Route _createRoute({required Widget widgetPage}) {
    return MaterialPageRoute(
      settings: RouteSettings(arguments: _args),
      builder: (context) {
        return widgetPage;
      },
      maintainState: false,
    );
  }
}
