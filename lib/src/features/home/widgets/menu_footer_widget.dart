import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordem_siai/src/features/home/controllers/home_page_controller.dart';

import '../../../core/app_colors.dart';
import '../../../core/app_images.dart';
import '../../../shared/widget/progress_indicator/progress_indicator_widget.dart';

class MenuFooterWidget extends StatelessWidget {
  final HomePageController controller;

  const MenuFooterWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Hero(
            tag: AppImages.logo,
            child: Image.asset(
              AppImages.logo,
              //width: 300,
              //height: 300,
            ),
          ),
        ),
        FutureBuilder(
          future: controller.loadAppVersion(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: ProgressIndicatorWidget.primary(
                context: context,
              ));
            } else if (snapshot.error != null) {
              print(snapshot.error);
              return Container();
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Versão: ${controller.appVersion}',
                  style: GoogleFonts.robotoSlab(
                    fontWeight: FontWeight.normal,
                    fontSize: 10,
                    color: AppColors.primary,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
