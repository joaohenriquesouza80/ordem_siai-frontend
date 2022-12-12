import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';

class SimpleAppBarWidget extends StatelessWidget {
  final String title;
  final double height;
  final double fontSize;
  final Function? onGoBack;

  const SimpleAppBarWidget({
    Key? key,
    required this.title,
    this.height = 100,
    this.fontSize = 26,
    this.onGoBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    goBack() {
      if (onGoBack == null) {
        Navigator.pop(context);
      } else {
        onGoBack!();
      }
    }

    return Container(
      height: height,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: SafeArea(
        child: SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              onGoBack != null
                  ? IconButton(
                      icon: const Icon(
                        FeatherIcons.chevronLeft,
                        color: AppColors.myWhite,
                        size: 26,
                      ),
                      onPressed: goBack,
                    )
                  : Container(),
              Text(
                title,
                style: GoogleFonts.robotoSlab(
                  fontWeight: FontWeight.normal,
                  fontSize: fontSize,
                  color: AppColors.myWhite,
                ),
              ),
              const SizedBox(width: 26),
            ],
          ),
        ),
      ),
    );
  }
}
