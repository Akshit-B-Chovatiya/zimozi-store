import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class AppBarView extends StatelessWidget {
  const AppBarView(
      {super.key,
      required this.title,
      this.titleColor = AppColors.whiteColor,
      this.prefixIcon,
      this.suffixIcon,
      this.onPrefixPressed,
        this.onSuffixPressed,
      this.iconColor = AppColors.whiteColor,
      this.backgroundColor = AppColors.orangeColor,
      this.titleTextSize = 20});

  final String title;
  final Color titleColor;
  final String? prefixIcon;
  final String? suffixIcon;
  final Color iconColor;
  final Color backgroundColor;
  final double titleTextSize;
  final Function()? onPrefixPressed;
  final Function()? onSuffixPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 7, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              prefixIcon != null
                  ? InkWell(
                      onTap: onPrefixPressed,
                      child: ImageView(
                          imageUrl: prefixIcon ?? "", height: 25, width: 25, isSVG: true, color: iconColor))
                  : Container(width: suffixIcon != null ? 25 : 0),
              BoldTextView(data: title, fontSize: titleTextSize, textColor: titleColor),
              suffixIcon != null
                  ? InkWell(
                      onTap: onSuffixPressed,
                      child: ImageView(
                          imageUrl: suffixIcon ?? "", height: 25, width: 25, isSVG: true, color: iconColor))
                  : Container(width: prefixIcon != null ? 25 : 0)
            ],
          ),
        ),
      ),
    );
  }
}
