import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class BottomBarIconView extends StatelessWidget {
  const BottomBarIconView(
      {super.key,
      required this.title,
      required this.iconPath,
      required this.isSelected,
      required this.onPressed});

  final String iconPath;
  final String title;
  final bool isSelected;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: AppColors.transparentColor,
      highlightColor: AppColors.transparentColor,
      child: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
              color: isSelected ? AppColors.orangeColor : AppColors.transparentColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(5))),
          child: Container(
            color: AppColors.whiteColor,
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ImageView(
                    imageUrl: iconPath,
                    isSVG: true,
                    height: 20,
                    width: 20,
                    color: isSelected ? AppColors.orangeColor : AppColors.greyColor),
                const SizedBox(height: 5),
                MediumTextView(
                    data: title,
                    textColor: isSelected ? AppColors.orangeColor : AppColors.greyColor,
                    bottomPadding: 8)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
