import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/account/account_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/screens/authetications/sign_in_screen.dart';
import 'package:zimozi_store/screens/tabs/account_tab/edit_profile_screen.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/dialog_services/process_confirmation_dialog.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_autehntication_service.dart';
import 'package:zimozi_store/utils/storage_services/shared_preferences.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/account_tab/account_tiles_view.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/divider_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

class _AccountTabState extends State<AccountTab> {
  @override
  void initState() {
    BlocProvider.of<AccountCubit>(context).getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarView(title: "Account"),
          Expanded(
              child: BlocConsumer<AccountCubit, AccountState>(
            listener: (context, state) {
              if (state is AccountAPILoadingState) {
                showLoadingDialog(context: context);
              } else if (state is AccountAPILoadedState) {
                hideLoadingDialog(context: context);
              } else if (state is AccountAPIErrorState) {
                hideLoadingDialog(context: context);
                showToastMessage(context: context, message: state.message, isErrorMessage: true);
              } else if (state is AccountErrorState) {
                showToastMessage(context: context, message: state.message, isErrorMessage: true);
              }
            },
            builder: (context, state) {
              AccountCubit cubit = BlocProvider.of<AccountCubit>(context);
              return state is AccountLoadingState
                  ? Center(child: LoadingView())
                  : state is AccountErrorState
                      ? Center(
                          child: SemiBoldTextView(
                              data: "Something went wrong!", fontSize: 20, textColor: AppColors.redColor))
                      : SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                          child: Column(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: AppColors.orangeColor)),
                                  height: MediaQuery.of(context).size.width / 4,
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Container(
                                    margin: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.whiteColor,
                                        border: Border.all(color: AppColors.orangeColor)),
                                    child: Container(
                                        margin: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, color: AppColors.whiteColor),
                                        child: cubit.zimoziUser?.profileImage != null &&
                                                cubit.zimoziUser!.profileImage!.isNotEmpty
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(
                                                    MediaQuery.of(context).size.width / 2),
                                                child: ImageView(
                                                    imageUrl: cubit.zimoziUser?.profileImage ?? "",
                                                    isAsset: false,
                                                    boxFit: BoxFit.cover),
                                              )
                                            : Center(
                                                child: SemiBoldTextView(
                                                data:
                                                    "${cubit.zimoziUser?.firstName?[0]}${cubit.zimoziUser?.lastName?[0]}",
                                                textColor: AppColors.orangeColor,
                                                fontSize: 30,
                                              ))),
                                  )),
                              SemiBoldTextView(
                                data:
                                    "${cubit.zimoziUser?.firstName ?? "--"} ${cubit.zimoziUser?.lastName ?? "--"}",
                                topPadding: 20,
                                fontSize: 18,
                              ),
                              MediumTextView(data: cubit.zimoziUser?.emailAddress ?? "--", topPadding: 5),
                              MediumTextView(data: cubit.zimoziUser?.phoneNumber ?? "--", topPadding: 5),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.greyColor.withValues(alpha: (0.2)),
                                          blurRadius: 10,
                                          spreadRadius: 10)
                                    ]),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                margin: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  children: [
                                    AccountTilesView(
                                        title: "Edit Profile",
                                        icon: AppImages.userIcon,
                                        onPressed: () {
                                          if (cubit.zimoziUser != null) {
                                            PageNavigator.pushPage(
                                                context: context,
                                                page: EditProfileScreen(
                                                  userDetails: cubit.zimoziUser!,
                                                  onSuccessUpdate: (v) async {
                                                    await LocalStorage.removeKey(
                                                        key: AppConstants.userDetails);
                                                    await cubit.getUserDetails();
                                                  },
                                                ));
                                          }
                                        }),
                                    DividerView(),
                                    AccountTilesView(
                                        title: "Privacy Policy",
                                        icon: AppImages.privacyPolicyIcon,
                                        onPressed: () {}),
                                    DividerView(),
                                    AccountTilesView(
                                        title: "Terms of services",
                                        icon: AppImages.termsOfServicesIcon,
                                        onPressed: () {}),
                                    DividerView(),
                                    AccountTilesView(
                                        title: "Settings", icon: AppImages.appSettingsIcon, onPressed: () {}),
                                    DividerView(),
                                    AccountTilesView(
                                        title: "Logout",
                                        icon: AppImages.logoutIcon,
                                        onPressed: () {
                                          showLogoutConfirmationDialog(
                                              context: context,
                                              onConfirmLogout: () async {
                                                await FirebaseAuthService.logout();
                                                await LocalStorage.clearStorage();
                                                if (context.mounted) {
                                                  PageNavigator.pushAndRemoveUntilPage(
                                                      context: context, page: SignInScreen());
                                                }
                                              });
                                        }),
                                  ],
                                ),
                              ),
                              RegularTextView(
                                data: AppConstants.appVersion,
                                fontSize: 12,
                                textColor: AppColors.greyColor,
                                topPadding: 30,
                              )
                            ],
                          ),
                        );
            },
          ))
        ],
      ),
    );
  }
}
