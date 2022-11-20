import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';

class InputTextWidget extends StatelessWidget {
  final BuildContext context;
  final String? label;
  final String? hint;
  final Color fillColor;
  final double radiusBorder;
  final Color borderColor;
  final Color focusedBorderColor;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String? Function(String?)? onValidate;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final String? inputMask;
  final AutovalidateMode? autovalidateMode;
  final String? errorText;
  final TextAlign? textAlign;
  final bool? autocorrect;

  const InputTextWidget({
    Key? key,
    this.label,
    this.hint,
    this.maxLength,
    required this.fillColor,
    required this.radiusBorder,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.obscureText,
    required this.keyboardType,
    required this.controller,
    this.onChanged,
    this.onValidate,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textCapitalization,
    this.inputMask,
    this.autovalidateMode,
    this.errorText,
    this.textAlign,
    this.autocorrect,
    required this.context,
  }) : super(key: key);

  InputTextWidget.white({
    super.key,
    this.label,
    this.hint,
    this.maxLength,
    required this.onChanged,
    required this.onValidate,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textCapitalization,
    this.inputMask,
    this.autovalidateMode,
    this.errorText,
    this.textAlign,
    this.autocorrect,
    required this.context,
  })  : fillColor = AppColors.myWhite,
        borderColor = AppColors.myWhite,
        focusedBorderColor = Theme.of(context).colorScheme.primary,
        radiusBorder = 10;

  InputTextWidget.transparent({
    super.key,
    this.label,
    this.hint,
    this.maxLength,
    required this.onChanged,
    required this.onValidate,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction,
    this.textCapitalization,
    this.inputMask,
    this.autovalidateMode,
    this.errorText,
    this.textAlign,
    this.autocorrect,
    required this.context,
  })  : fillColor = Colors.transparent,
        borderColor = AppColors.myWhite,
        focusedBorderColor = Colors.transparent,
        radiusBorder = 0;

  @override
  Widget build(BuildContext context) {
    FocusNode getFocusNode() {
      return focusNode != null ? focusNode! : FocusNode();
    }

    return TextFormField(
      autocorrect: autocorrect ?? true,
      textAlign: textAlign ?? TextAlign.start,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusBorder),
          borderSide: BorderSide(
            color: focusedBorderColor,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusBorder),
          borderSide: BorderSide(
            color: borderColor,
            style: BorderStyle.solid,
            width: 1,
          ),
        ),
        fillColor: fillColor,
        filled: true,
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.tertiary,
          //_getFocusNode().hasFocus ? AppColors.myWhite : AppColors.tertiary,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color:
              getFocusNode().hasFocus ? AppColors.myWhite : AppColors.tertiary,
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(12),
        counterText: "",
        errorText: errorText,
      ),
      onChanged: onChanged,
      validator: onValidate,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      inputFormatters: inputMask == null
          ? null
          : [
              TextInputMask(
                mask: inputMask,
                reverse: false,
                placeholder: '_',
                maxPlaceHolders: inputMask!.length,
              )
            ],
      autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
    );
  }
}
