import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

void showLogoutConfirmationDialog({required BuildContext context, required Function() onConfirmLogout}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return ProcessConfirmationDialog(
            onConfirmPressed: onConfirmLogout,
            title: "See you soon!",
            buttonName: "Logout",
            description: "You are about to logout.\nAre you sure this is what\nyou want?");
      });
}

void showDeleteAccountConfirmationDialog(
    {required BuildContext context, required Function() onConfirmPressed}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (BuildContext context) {
        return ProcessConfirmationDialog(
            onConfirmPressed: onConfirmPressed,
            title: "Delete Account!",
            buttonName: "Delete",
            description: "You are about to delete your account.\nAre you sure this is what\nyou want?");
      });
}

class ProcessConfirmationDialog extends StatelessWidget {
  const ProcessConfirmationDialog(
      {super.key,
      required this.onConfirmPressed,
      required this.description,
      required this.buttonName,
      required this.title});

  final String title;
  final String description;
  final String buttonName;
  final Function() onConfirmPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Material(
            color: AppColors.transparentColor,
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ImageView(
                          imageUrl: AppImages.appLogoImage,
                          height: MediaQuery.of(context).size.width / 5,
                          width: MediaQuery.of(context).size.width / 5),
                      SemiBoldTextView(
                          data: title,
                          textColor: AppColors.orangeColor,
                          textAlign: TextAlign.center,
                          fontSize: 22,
                          bottomPadding: 10),
                      MediumTextView(
                          data: description,
                          textColor: AppColors.greyColor,
                          textAlign: TextAlign.center,
                          fontSize: 16,
                          bottomPadding: 15),
                      Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                            InkWell(
                                onTap: () {
                                  PageNavigator.pop(context: context);
                                },
                                child: const SemiBoldTextView(
                                    data: "Cancel",
                                    textDecoration: TextDecoration.underline,
                                    textColor: AppColors.blackColor)),
                            ButtonView(
                                title: buttonName,
                                width: MediaQuery.of(context).size.width / 4,
                                topMargin: 0,
                                rightMargin: 0,
                                topPadding: 10,
                                bottomMargin: 0,
                                bottomPadding: 10,
                                textSize: 12,
                                borderColor: AppColors.redColor,
                                buttonColor: AppColors.redColor.withValues(alpha: (0.1)),
                                textColor: AppColors.redColor,
                                onTap: () {
                                  PageNavigator.pop(context: context);
                                  onConfirmPressed();
                                })
                          ]))
                    ]))));
  }
}
