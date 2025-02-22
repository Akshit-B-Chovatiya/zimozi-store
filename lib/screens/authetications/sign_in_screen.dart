import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/authentications/sign_in/sign_in_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/config/app_text_style.dart';
import 'package:zimozi_store/screens/authetications/forgot_password_screen.dart';
import 'package:zimozi_store/screens/authetications/sign_up_screen.dart';
import 'package:zimozi_store/screens/dashboard/dashboard_screen.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_field_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        children: [
          Container(
            decoration: BoxDecoration(gradient: AppColors.appBackgroundLinearGradient),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: SafeArea(
              child: Container(
                decoration:
                    BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(20)),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: BlocProvider(
                  create: (context) => SignInCubit(),
                  child: BlocConsumer<SignInCubit, SignInState>(
                    listener: (context, state) {
                      if (state is SignInLoadingState) {
                        showLoadingDialog(context: context);
                      } else if (state is SignInLoadedState) {
                        hideLoadingDialog(context: context);
                        showToastMessage(context: context, message: state.message);
                        PageNavigator.pushAndRemoveUntilPage(context: context, page: DashboardScreen());
                      } else if (state is SignInErrorState) {
                        hideLoadingDialog(context: context);
                        showToastMessage(context: context, message: state.message, isErrorMessage: true);
                      }
                    },
                    builder: (context, state) {
                      SignInCubit cubit = BlocProvider.of<SignInCubit>(context);
                      return Column(
                        children: [
                          BoldTextView(
                              data: "Welcome to",
                              textColor: AppColors.blackColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w800),
                          ImageView(
                              imageUrl: AppImages.appLogoImage,
                              height: MediaQuery.of(context).size.width / 4,
                              width: MediaQuery.of(context).size.width / 4),
                          SemiBoldTextView(data: "Sign into your account", textColor: AppColors.greyColor),
                          TextFieldView(
                              controller: cubit.emailController, label: "Email", hint: "Enter your email"),
                          TextFieldView(
                              controller: cubit.passwordController,
                              label: "Password",
                              hint: "Enter your password"),
                          Container(
                              alignment: Alignment.centerRight,
                              child: InkWell(
                                onTap: () {
                                  PageNavigator.pushPage(
                                      context: context,
                                      page: ForgotPasswordScreen(),
                                      onComplete: () {
                                        cubit.clearForm();
                                      });
                                },
                                child: SemiBoldTextView(
                                    data: "Forgot password?",
                                    textColor: AppColors.orangeColor,
                                    textAlign: TextAlign.right,
                                    topPadding: 15,
                                    bottomPadding: 20),
                              )),
                          ButtonView(
                              title: "Sign In",
                              bottomMargin: 30,
                              onTap: () async {
                                await cubit.validateAndSignIn(context: context);
                              }),
                          RichText(
                              text: TextSpan(
                                  text: "Don't have an account? ",
                                  style: AppTextStyle.mediumTextStyle.copyWith(fontSize: 16),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign Up',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        PageNavigator.pushPage(
                                            context: context,
                                            page: SignUpScreen(),
                                            onComplete: () {
                                              cubit.clearForm();
                                            });
                                      },
                                    style: AppTextStyle.boldTextStyle
                                        .copyWith(color: AppColors.orangeColor, fontSize: 16))
                              ]))
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
