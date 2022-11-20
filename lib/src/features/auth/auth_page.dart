import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';
import '../../core/app_images.dart';
import '../../shared/routes/app_routes_names.dart';
import '../../shared/utils/display_dialog.dart';
import '../../shared/widget/button/button_widget.dart';
import '../../shared/widget/input_text/input_text_widget.dart';
import 'providers/auth_provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text;
    final password = _passwordController.text;

    final authProvider = context.read<AuthProvider>();
    try {
      await authProvider.login(email, password);
    } catch (e) {
      DisplayDialog.showDialogAsync(
        context,
        "Erro na Autenticação",
        e.toString(),
        FeatherIcons.frown,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      //resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Hero(
                    tag: AppImages.logo,
                    child: Image.asset(
                      AppImages.logo,
                      width: 300,
                      height: 300,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 50),
              Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Ordem SIAI",
                        style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          color: Theme.of(context).textTheme.titleLarge!.color,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Faça seu login",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.titleMedium!.color,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 400,
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            InputTextWidget.white(
                              controller: _emailController,
                              hint: "E-Mail",
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (text) {},
                              onValidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe seu email';
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              context: context,
                            ),
                            const SizedBox(height: 5),
                            InputTextWidget.white(
                              controller: _passwordController,
                              hint: "Senha",
                              autocorrect: false,
                              obscureText: true,
                              onChanged: (text) {},
                              onValidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Informe sua senha';
                                }
                                return null;
                              },
                              context: context,
                            ),
                            const SizedBox(height: 5),
                            ButtonWidget.tertiaryWithoutBords(
                              label: 'Esqueci minha senha',
                              fontSize: 14,
                              onTap: () {},
                              context: context,
                              textAlign: TextAlign.right,
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              child: ButtonWidget.primary(
                                fontSize: 16,
                                label: 'Entrar',
                                isLoading: _isLoading,
                                onTap: handleLogin,
                                context: context,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: SizedBox(
          width: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ButtonWidget.tertiaryWithoutBords(
              label: 'Criar uma conta',
              fontSize: 18,
              icon: FeatherIcons.userPlus,
              onTap: () {},
              context: context,
            ),
          ),
        ),
      ),
    );
  }
}
