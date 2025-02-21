import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class ButtonView extends StatelessWidget {
  const ButtonView(
      {super.key,
      required this.title,
      required this.onTap,
      this.isRoundedBorder = false,
      this.leftPadding = 0,
      this.rightPadding = 0,
      this.topPadding = 12,
      this.bottomPadding = 12,
      this.bottomMargin = 15,
      this.leftMargin = 0,
      this.rightMargin = 0,
      this.topMargin = 15,
      this.textSize = 18,
      this.borderColor = AppColors.orangeColor,
      this.height,
      this.width,
      this.boxShadow,
      this.textColor = AppColors.whiteColor,
      this.textAlign = TextAlign.center,
      this.buttonColor = AppColors.orangeColor,
      this.leftIcon,
      this.rightIcon,
      this.borderRadius,
      this.fontFamily = AppConstants.manRopeFamily,
      this.buttonGradient,
      this.fontWeight = FontWeight.w700,
      this.mainAxisAlignment = MainAxisAlignment.center});

  final String title;
  final Function() onTap;
  final bool isRoundedBorder;
  final double topPadding;
  final double bottomPadding;
  final double rightPadding;
  final double leftPadding;
  final double topMargin;
  final double bottomMargin;
  final double leftMargin;
  final double rightMargin;
  final double? textSize;
  final double? height;
  final double? width;
  final Color? textColor;
  final Color? buttonColor;
  final TextAlign? textAlign;
  final Color? borderColor;
  final List<BoxShadow>? boxShadow;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final BorderRadius? borderRadius;
  final String fontFamily;
  final FontWeight fontWeight;
  final Gradient? buttonGradient;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topMargin, bottom: bottomMargin, left: leftMargin, right: rightMargin),
      height: height,
      width: width,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(isRoundedBorder ? 50 : 5)),
        child: Container(
          height: height,
          width: width,
          padding:
              EdgeInsets.only(top: topPadding, bottom: bottomPadding, left: leftPadding, right: rightPadding),
          decoration: BoxDecoration(
            color: buttonColor,
            border: borderColor == null ? null : Border.all(color: borderColor!),
            boxShadow: boxShadow,
            borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(isRoundedBorder ? 50 : 5)),
            gradient: buttonGradient,
          ),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              leftIcon != null ? leftIcon! : Container(),
              BoldTextView(
                  data: title,
                  fontSize: textSize,
                  textColor: textColor,
                  textAlign: textAlign,
                  fontWeight: fontWeight,
                  fontFamily: fontFamily),
              rightIcon != null ? rightIcon! : Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class IconButtonView extends StatelessWidget {
  const IconButtonView(
      {super.key,
      required this.icon,
      required this.onPressed,
      this.iconColor = AppColors.orangeColor,
      this.borderColor = AppColors.orangeColor,
      this.isEnable = true,
      this.radius = 20,
      this.iconSize = 22,
      this.height = 35,
      this.width = 35,
      this.backgroundColor = AppColors.whiteColor,
      this.leftMargin = 0,
      this.rightMargin = 0,
      this.topMargin = 0,
      this.bottomMargin = 0});

  final IconData icon;
  final Color iconColor;
  final Color borderColor;
  final bool isEnable;
  final Function()? onPressed;
  final double radius;
  final double iconSize;
  final double height;
  final double width;
  final Color backgroundColor;
  final double topMargin;
  final double bottomMargin;
  final double leftMargin;
  final double rightMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin, top: topMargin, left: leftMargin, right: rightMargin),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: () {
          if (isEnable) {
            onPressed!();
          }
        },
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(radius)),
          child: Center(child: Icon(icon, color: iconColor, size: iconSize)),
        ),
      ),
    );
  }
}

class BackButtonView extends StatelessWidget {
  const BackButtonView(
      {super.key, this.leftMargin = 15, this.rightMargin = 0, this.topMargin = 5, this.bottomMargin = 10});

  final double topMargin;
  final double bottomMargin;
  final double leftMargin;
  final double rightMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin, top: topMargin, left: leftMargin, right: rightMargin),
      child: InkWell(
          onTap: () {
            PageNavigator.pop(context: context);
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(color: AppColors.orangeColor, shape: BoxShape.circle),
              child: const Center(
                  child: Icon(Icons.keyboard_backspace_rounded, color: AppColors.whiteColor, size: 22.5)))),
    );
  }
}
