import 'package:flutter/material.dart';
import 'package:ordem_siai/src/shared/widget/button/button_widget.dart';
import 'package:provider/provider.dart';

import '../../core/app_colors.dart';
import '../../shared/widget/progress_indicator/progress_indicator_widget.dart';
import '../../shared/widget/simple_app_bar/simple_app_bar_widget.dart';
import '../../shared/widget/text_message/text_message_widget.dart';
import 'controllers/packages_controller.dart';
import 'providers/packages_provider.dart';
import 'widgets/packages_list_widget.dart';

class PackagesPage extends StatelessWidget {
  final PageController pageController;

  const PackagesPage({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    PackagesController packagesController =
        PackagesController(context, pageController);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SimpleAppBarWidget(
          title: 'Pacotes',
        ),
      ),
      body: FutureBuilder(
          future: packagesController.loadAllPackages(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: ProgressIndicatorWidget.primary(
                  context: context,
                ),
              );
            } else if (snapshot.error != null) {
              print(snapshot.error);
              return const Center(
                child: TextMessageWidget(
                  message: 'Erro ao recuperar os Pacotes\nTente novamente.',
                  color: AppColors.darkRed,
                ),
              );
            } else {
              return Consumer<PackagesProvider>(
                builder: (ctx, provider, child) {
                  return Padding(
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
                                onTap: packagesController.handleAddNewPackage,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        PackagesListWidget(
                          controller: packagesController,
                          packages: provider.packages,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
