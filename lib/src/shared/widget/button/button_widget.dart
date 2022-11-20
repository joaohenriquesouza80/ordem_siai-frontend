import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_colors.dart';
import '../progress_indicator/progress_indicator_widget.dart';

class ButtonWidget extends StatelessWidget {
  final BuildContext context;
  final double fontSize;
  final double radiusButton;
  final Color fontColor;
  final Color borderColor;
  final Color backgroundColor;
  final String label;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final VoidCallback? onTap;
  final bool isLoading;
  final TextAlign textAlign;

  const ButtonWidget({
    Key? key,
    required this.context,
    required this.fontSize,
    required this.radiusButton,
    required this.fontColor,
    required this.borderColor,
    required this.backgroundColor,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.onTap,
    required this.isLoading,
    required this.textAlign,
  }) : super(key: key);

  ButtonWidget.primary({
    super.key,
    required this.context,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    this.isLoading = false,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        backgroundColor = Theme.of(context).colorScheme.primary,
        fontColor = AppColors.myWhite,
        iconColor = AppColors.myWhite,
        borderColor = Theme.of(context).colorScheme.primary;

  ButtonWidget.secondary({
    super.key,
    required this.context,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    this.isLoading = false,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        backgroundColor = AppColors.secondary,
        fontColor = AppColors.tertiary,
        iconColor = AppColors.tertiary,
        borderColor = AppColors.secondary;

  const ButtonWidget.needColor({
    super.key,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    required this.backgroundColor,
    required this.fontColor,
    this.isLoading = false,
    required this.context,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        iconColor = fontColor,
        borderColor = backgroundColor;

  ButtonWidget.tertiaryWithoutBords({
    super.key,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    this.isLoading = false,
    required this.context,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        backgroundColor = Colors.transparent,
        fontColor = AppColors.tertiary,
        iconColor = AppColors.tertiary,
        borderColor = Colors.transparent;

  ButtonWidget.redWithoutBords({
    super.key,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    this.isLoading = false,
    required this.context,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        backgroundColor = Colors.transparent,
        fontColor = AppColors.darkRed,
        iconColor = AppColors.darkRed,
        borderColor = Colors.transparent;

  ButtonWidget.orange({
    super.key,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    this.isLoading = false,
    required this.context,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        backgroundColor = AppColors.orange,
        fontColor = AppColors.myWhite,
        iconColor = AppColors.myWhite,
        borderColor = AppColors.myWhite;

  ButtonWidget.fullOrange({
    super.key,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    this.isLoading = false,
    required this.context,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        backgroundColor = AppColors.orange,
        fontColor = AppColors.myWhite,
        iconColor = AppColors.myWhite,
        borderColor = AppColors.orange;

  ButtonWidget.whiteWithoutBords({
    super.key,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    this.isLoading = false,
    required this.context,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        backgroundColor = Colors.transparent,
        fontColor = AppColors.myWhite,
        iconColor = AppColors.myWhite,
        borderColor = Colors.transparent;

  ButtonWidget.orangeWithoutBords({
    super.key,
    required this.label,
    this.onTap,
    // ignore: avoid_init_to_null
    this.icon = null,
    this.iconSize = 16,
    this.fontSize = 14,
    this.isLoading = false,
    required this.context,
    this.textAlign = TextAlign.center,
  })  : radiusButton = 10,
        backgroundColor = Colors.transparent,
        fontColor = AppColors.orange,
        iconColor = AppColors.orange,
        borderColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(backgroundColor),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusButton),
        )),
        side: MaterialStateProperty.all(
          BorderSide(color: borderColor),
        ),
      ),
      onPressed: isLoading ? null : onTap,
      child: Container(
        child: isLoading
            ? ProgressIndicatorWidget(
                color: onTap == null ? AppColors.myGrey : fontColor,
                context: context,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null
                      ? Row(
                          children: <Widget>[
                            Icon(
                              icon,
                              color: iconColor,
                              size: iconSize,
                            ),
                            const SizedBox(width: 8),
                          ],
                        )
                      : Container(),
                  Expanded(
                    child: AutoSizeText(
                      label,
                      maxLines: 2,
                      textAlign: textAlign,
                      style: GoogleFonts.notoSans(
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold,
                        color: onTap == null ? AppColors.myGrey : fontColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
