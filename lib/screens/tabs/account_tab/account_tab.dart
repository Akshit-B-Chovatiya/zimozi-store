import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/screens/authetications/sign_in_screen.dart';
import 'package:zimozi_store/utils/dialog_services/process_confirmation_dialog.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/account_tab/account_tiles_view.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/divider_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarView(title: "Account"),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orangeColor),
                    height: MediaQuery.of(context).size.width / 4,
                    width: MediaQuery.of(context).size.width / 4,
                    child: Container(
                      margin: EdgeInsets.all(2),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor),
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.orangeColor),
                          child: Container(
                              margin: EdgeInsets.all(2),
                              decoration:
                                  BoxDecoration(shape: BoxShape.circle, color: AppColors.whiteColor))),
                    )),
                SemiBoldTextView(
                  data: "Akshit Chovatiya",
                  topPadding: 20,
                  fontSize: 18,
                ),
                MediumTextView(data: "akshitchovatiya98@gmail.com", topPadding: 5),
                MediumTextView(data: "+91 8978675645", topPadding: 5),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.whiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.greyColor.withValues(alpha: (0.2)), blurRadius: 10, spreadRadius: 10)
                      ]),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      AccountTilesView(title: "Edit Profile", icon: AppImages.userIcon, onPressed: () {}),
                      DividerView(),
                      AccountTilesView(
                          title: "Privacy Policy", icon: AppImages.privacyPolicyIcon, onPressed: () {}),
                      DividerView(),
                      AccountTilesView(
                          title: "Terms of services", icon: AppImages.termsOfServicesIcon, onPressed: () {}),
                      DividerView(),
                      AccountTilesView(title: "Settings", icon: AppImages.appSettingsIcon, onPressed: () {}),
                      DividerView(),
                      AccountTilesView(
                          title: "Logout",
                          icon: AppImages.logoutIcon,
                          onPressed: () {
                            showLogoutConfirmationDialog(
                                context: context,
                                onConfirmLogout: () {
                                  PageNavigator.pushAndRemoveUntilPage(
                                      context: context, page: SignInScreen());
                                });
                          }),
                    ],
                  ),
                ),
                RegularTextView(
                    data: AppConstants.appVersion, fontSize: 12, textColor: AppColors.greyColor,topPadding: 30,)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
