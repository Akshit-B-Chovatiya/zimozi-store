import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/authentications/forgot_password/forgot_password_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_field_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: AppColors.appBackgroundLinearGradient),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            bottom: false,
            child: IconButtonView(
                icon: Icons.keyboard_backspace_rounded,
                bottomMargin: 15,
                onPressed: () {
                  PageNavigator.pop(context: context);
                }),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              children: [
                Container(
                  decoration:
                      BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: BlocProvider(
                    create: (context) => ForgotPasswordCubit(),
                    child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
                      listener: (context, state) {
                        if (state is ForgotPasswordLoadingState) {
                          showLoadingDialog(context: context);
                        } else if (state is ForgotPasswordLoadedState) {
                          hideLoadingDialog(context: context);
                          showToastMessage(context: context, message: state.message);
                        } else if (state is ForgotPasswordErrorState) {
                          hideLoadingDialog(context: context);
                          showToastMessage(context: context, message: state.message, isErrorMessage: true);
                        }
                      },
                      builder: (context, state) {
                        ForgotPasswordCubit cubit = BlocProvider.of<ForgotPasswordCubit>(context);
                        return Column(children: [
                          BoldTextView(
                              data: "Forgot your password?",
                              textColor: AppColors.blackColor,
                              fontSize: 18,
                              bottomPadding: 10,
                              fontWeight: FontWeight.w800),
                          ImageView(
                              imageUrl: AppImages.appLogoImage,
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 4),
                          SemiBoldTextView(
                              data: "Verify and create new password",
                              textColor: AppColors.greyColor,
                              bottomPadding: 10),
                          TextFieldView(
                              controller: cubit.emailController, label: "Email", hint: "Enter your email"),
                          Visibility(
                              visible: cubit.isOTPSent,
                              child: SemiBoldTextView(
                                  data: "Enter verification code sent to\n${cubit.emailController.text}",
                                  textAlign: TextAlign.center,
                                  textColor: AppColors.greyColor,
                                  fontSize: 12,
                                  topPadding: 25)),
                          Visibility(
                              visible: cubit.isOTPSent,
                              child: TextFieldView(
                                  controller: cubit.verificationCodeController,
                                  label: "Verification Code",
                                  hint: "Enter verification code")),
                          Visibility(
                              visible: cubit.isOTPVerified,
                              child: SemiBoldTextView(
                                  data: "Create New Password",
                                  textColor: AppColors.greyColor,
                                  fontSize: 12,
                                  topPadding: 25)),
                          Visibility(
                              visible: cubit.isOTPVerified,
                              child: TextFieldView(
                                  controller: cubit.newPasswordController,
                                  label: "New Password",
                                  hint: "Enter new password")),
                          Visibility(
                              visible: cubit.isOTPVerified,
                              child: TextFieldView(
                                  controller: cubit.newConfirmPasswordController,
                                  label: "Confirm Password",
                                  hint: "Enter confirmation password")),
                          ButtonView(
                              title: cubit.isOTPVerified
                                  ? "Update Password"
                                  : cubit.isOTPSent
                                      ? "Verify Code"
                                      : "Send Verification Code",
                              bottomMargin: 30,
                              onTap: () async {
                                await cubit.validateAndDoProcessForForgotPassword(context: context);
                              })
                        ]);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
