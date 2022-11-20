import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../shared/routes/app_routes_names.dart';
import '../../shared/widget/text_message/text_message_widget.dart';
import '../home/controllers/home_page_controller.dart';
import '../home/home_page.dart';
import '../splash/splash_page.dart';
import 'auth_page.dart';
import 'providers/auth_provider.dart';

class AuthOrHomePage extends StatelessWidget {
  bool _needExecuteStartProcess = true;

  AuthOrHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of(context);
    final homePageController = HomePageController(context);

    getAuthPage() {
      _needExecuteStartProcess = true;
      return const AuthPage();
    }

    goToHome() async {
      Navigator.pushReplacementNamed(
        context,
        AppRoutesNames.HOME,
      );
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const HomePage()));
    }

    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //return const SplashPage();
          return Container();
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.isAuth
              ? _needExecuteStartProcess == false
                  ? const HomePage()
                  : FutureBuilder(
                      future: homePageController.startProcess(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SplashPage();
                        } else if (snapshot.error != null) {
                          print(snapshot.error);
                          return RefreshIndicator(
                            onRefresh: homePageController.startProcess,
                            child: ListView(
                              children: [
                                Center(
                                  child: TextMessageWidget(
                                    message:
                                        'Erro ao carregar Pagina Principal\nTente novamente.',
                                    color: AppColors.darkRed,
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          _needExecuteStartProcess = false;
                          return const HomePage();
                        }
                      },
                    )
              : getAuthPage();
        }
      },
    );
  }
}
