import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_text_style.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class TextFieldView extends StatelessWidget {
  const TextFieldView(
      {super.key,
      required this.controller,
      this.hint = "",
      this.label = "",
      this.textInputType = TextInputType.text,
      this.cursorColor = AppColors.orangeColor,
      this.borderColor = AppColors.greyColor,
      this.topPadding = 5,
      this.bottomPadding = 5,
      this.leftPadding = 0,
      this.rightPadding = 0,
      this.leftMargin = 0,
      this.rightMargin = 0,
      this.topMargin = 5,
      this.bottomMargin = 5,
      this.isReadOnly = false,
      this.onTap,
      this.onChanged,
      this.onSubmit,
      this.maxLine = 1,
      this.suffixIcon,
      this.prefixIcon,
      this.radius = 5,
      this.borderRadius,
      this.fontWeight = FontWeight.w500,
      this.fontSize,
      this.maxLength,
      this.textCapitalization,
      this.inputFormatters,
      this.suffix,
      this.prefix,
      this.icon,
      this.filledColor = AppColors.transparentColor,
      this.isDense = true,
      this.textAlign = TextAlign.start,
      this.textInputAction,
      this.focusNode,
      this.isObscureText = false,
      this.obscureText = "❋",
      this.autoFillHints,
      this.isMandatory = false});

  final TextInputType textInputType;
  final TextEditingController controller;
  final String hint;
  final String label;
  final Color cursorColor;
  final Color borderColor;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;
  final double leftMargin;
  final double rightMargin;
  final double topMargin;
  final double bottomMargin;
  final bool isReadOnly;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final int maxLine;
  final Widget? suffix;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? icon;
  final double radius;
  final BorderRadius? borderRadius;
  final FontWeight fontWeight;
  final double? fontSize;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool isDense;
  final Color filledColor;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final bool isObscureText;
  final String obscureText;
  final List<String>? autoFillHints;
  final bool isMandatory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.isNotEmpty
            ? MediumTextView(
                data: label,
                textColor: AppColors.blackColor,
                fontSize: fontSize ?? 16,
                topPadding: 10,
                bottomPadding: 5,
                fontWeight: fontWeight)
            : Container(),
        Container(
          margin: EdgeInsets.only(bottom: bottomMargin, top: topMargin, left: leftMargin, right: rightMargin),
          padding:
              EdgeInsets.only(bottom: bottomPadding, top: topPadding, left: leftPadding, right: rightPadding),
          decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(color: borderColor),
              borderRadius: borderRadius ?? BorderRadius.circular(5)),
          child: TextField(
              controller: controller,
              readOnly: isReadOnly,
              focusNode: focusNode,
              autofillHints: autoFillHints,
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              onTap: onTap,
              onChanged: onChanged,
              onSubmitted: onSubmit,
              maxLines: maxLine,
              maxLength: maxLength,
              obscureText: isObscureText,
              obscuringCharacter: obscureText,
              textAlign: textAlign,
              textInputAction: textInputAction,
              inputFormatters: inputFormatters,
              style: AppTextStyle.semiBoldTestStyle
                  .copyWith(color: AppColors.blackColor, fontSize: fontSize ?? 14, fontWeight: fontWeight),
              decoration: InputDecoration(
                  alignLabelWithHint: false,
                  hintText: hint + (isMandatory ? "*" : ""),
                  isDense: isDense,
                  counterText: "",
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  prefix: prefix,
                  suffix: suffix,
                  icon: icon,
                  hintStyle: AppTextStyle.mediumTextStyle
                      .copyWith(color: AppColors.greyColor, fontSize: fontSize ?? 14, fontWeight: fontWeight),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusColor: AppColors.orangeColor),
              keyboardType: textInputType,
              cursorColor: cursorColor),
        ),
      ],
    );
  }
}
