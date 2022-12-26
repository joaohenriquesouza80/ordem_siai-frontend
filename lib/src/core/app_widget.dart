import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../features/splash/splash_page.dart';
import '../shared/providers/app_providers.dart';
import '../shared/routes/app_routes.dart';
import 'app_theme.dart';

class AppWidget extends StatelessWidget {
  final AppRoutes _appRoutes = AppRoutes();

  AppWidget({super.key});

  Future<void> init(BuildContext context) async {
    debugPrint("Initializing App...");
    //Future.delayed(const Duration(seconds: 10), () {
    //  print("1 second has passed");
    //});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(context),
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: SplashPage(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          return AppProviders(
            child: MaterialApp(
              theme: AppTheme.getTheme(context),
              localizationsDelegates: const [
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [Locale('pt', 'BR')],
              debugShowCheckedModeBanner: false,
              title: 'SIAI',
              //home: const HomePage(),
              initialRoute: _appRoutes.initialRoute,
              //onGenerateRoute: _appRoutes.doGenerateRoutes,
              routes: _appRoutes.getRoutes(context),
            ),
          );
        }
      },
    );
  }
}
