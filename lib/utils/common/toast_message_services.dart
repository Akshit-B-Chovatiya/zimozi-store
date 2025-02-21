import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

void showToastMessage({required BuildContext context, required String message, bool isErrorMessage = false}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  SnackBar snackBar = SnackBar(
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(10),
      elevation: 0,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.transparentColor,
      content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
              color: isErrorMessage ? AppColors.redColor : AppColors.orangeColor,
              borderRadius: BorderRadius.circular(10)),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  SemiBoldTextView(data: message, fontSize: 16, textColor: AppColors.whiteColor)
                ]))
          ])));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
