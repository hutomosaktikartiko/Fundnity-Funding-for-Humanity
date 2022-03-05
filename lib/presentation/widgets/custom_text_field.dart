import 'package:flutter/material.dart';

import '../../core/config/custom_color.dart';
import '../../core/config/custom_text_style.dart';
import '../../core/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? suffixText, hintText, labelText;
  final int maxLines, minLines;
  final double paddingVertical, paddingHorizontal, borderRadius;
  final TextStyle? suffixStyle, hintStyle, style;
  final TextAlign? textAlign;
  final Widget? prefixIcon, suffixWidget;
  final Color enabledBorderColor, focusedBorderColor, fillColor;
  final Function? onTap, onChanged, onEditingComplete;
  final bool autofocus, obscureText, readOnly;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String value)? onFieldSubmitted;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.maxLines = 1,
    this.minLines = 1,
    this.suffixText,
    this.hintText,
    this.paddingVertical = 12,
    this.fillColor = Colors.white,
    this.paddingHorizontal = 16,
    this.labelText,
    this.borderRadius = 4,
    this.suffixStyle,
    this.hintStyle,
    this.textAlign,
    this.focusNode,
    this.prefixIcon,
    this.enabledBorderColor = UniversalColor.gray3,
    this.focusedBorderColor = UniversalColor.green4,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
    this.onEditingComplete,
    this.style,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.suffixWidget,
    this.textInputAction = TextInputAction.done,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: minLines,
      maxLines: maxLines,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      textInputAction: textInputAction,
      onChanged: (text) {
        if (onChanged != null) {
          onChanged!();
        }
      },
      onEditingComplete: () {
        Utils.hideKeyboard(context);
        if (onEditingComplete != null) {
          onEditingComplete!();
        }
      },
      onFieldSubmitted: (text) {
        if (onFieldSubmitted != null) {
          onFieldSubmitted!;
        }
      },
      autofocus: autofocus,
      readOnly: readOnly,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textAlign: textAlign ?? TextAlign.start,
      style: style ?? CustomTextStyle.blackTextStyle.copyWith(fontSize: 13),
      decoration: InputDecoration(
        hintText: hintText ?? "",
        focusedBorder: outlineInputFocusedBorder(
          borderRadius: borderRadius,
          borderColor: focusedBorderColor,
        ),
        enabledBorder: outlineInputEnableBorder(
          borderRadius: borderRadius,
          borderColor: enabledBorderColor,
        ),
        filled: true,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(
          vertical: paddingVertical,
          horizontal: paddingHorizontal,
        ),
        hintStyle:
            hintStyle ?? CustomTextStyle.blackTextStyle.copyWith(fontSize: 13),
        fillColor: fillColor,
        suffixText: suffixText,
        labelText: labelText,
        suffixIcon: suffixWidget,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: CustomTextStyle.blackTextStyle.copyWith(fontSize: 12),
        suffixStyle: suffixStyle ??
            CustomTextStyle.blackTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

InputBorder? outlineInputFocusedBorder({
  double? borderRadius,
  required Color borderColor,
}) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular((borderRadius == null) ? 10 : borderRadius),
      ),
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );

InputBorder? outlineInputEnableBorder({
  double? borderRadius,
  required Color borderColor,
}) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular((borderRadius == null) ? 10 : borderRadius),
      ),
      borderSide: BorderSide(
        color: borderColor,
        width: 1,
      ),
    );
