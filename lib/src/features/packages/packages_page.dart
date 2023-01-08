import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ordem_siai/src/shared/widget/button/button_widget.dart';

import '../../core/app_colors.dart';
import '../../shared/widget/progress_indicator/progress_indicator_widget.dart';
import '../../shared/widget/simple_app_bar/simple_app_bar_widget.dart';
import '../../shared/widget/text_message/text_message_widget.dart';
import 'controllers/packages_controller.dart';
import 'providers/packages_provider.dart';
import 'widgets/packages_list_widget.dart';

class PackagesPage extends StatefulWidget {
  final PageController? pageController;
  final String? queryParam;

  const PackagesPage({
    super.key,
    this.queryParam,
    required this.pageController,
  });

  @override
  State<PackagesPage> createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  late final PackagesController _packagesController;
  @override
  void initState() {
    print("PackageParam: ${widget.queryParam ?? ''}");

    //const p =
    //    "Y2Fyb2xfaWx1c3RyZUBhbHRhYWRzLmNvbS5icjpWUVhHWlNYN1oxQmVWV0JPRHVyS0RrWGU=";

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _packagesController = PackagesController(context, widget.pageController);

      setState(() {
        _init(widget.queryParam);
      });
    });
    super.initState();
  }

  _init(String? loginUser) async {
    if (loginUser != null) {
      await _packagesController.loginUser(loginUser);
    }
    await _packagesController.loadAllPackages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SimpleAppBarWidget(
          title: 'Pacotes',
        ),
      ),
      body: Consumer<PackagesProvider>(
        builder: (ctx, provider, child) {
          return provider.isLoading
              ? Center(
                  child: ProgressIndicatorWidget.primary(
                    context: context,
                  ),
                )
              : Consumer<PackagesProvider>(
                  builder: (ctx, provider, child) {
                    return provider.isError
                        ? Center(
                            child: TextMessageWidget(
                              message:
                                  'Erro ao recuperar os Pacotes:\n ${provider.errorMessage} \n\nTente novamente.',
                              color: AppColors.darkRed,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 300,
                                      child: ButtonWidget.secondary(
                                        context: ctx,
                                        label: 'Cadastrar novo Pacote',
                                        onTap: _packagesController
                                            .handleAddNewPackage,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                PackagesListWidget(
                                  controller: _packagesController,
                                  packages: provider.packages,
                                ),
                              ],
                            ),
                          );
                  },
                );
        },
      ),
    );
  }
}
