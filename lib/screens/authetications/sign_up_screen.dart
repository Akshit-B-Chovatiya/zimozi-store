import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/authentications/sign_up/sign_up_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/config/app_text_style.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/services/keyboard_services.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_field_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                      create: (context) => SignUpCubit(),
                      child: BlocConsumer<SignUpCubit, SignUpState>(
                        listener: (context, state) {
                          if (state is SignUpLoadingState) {
                            showLoadingDialog(context: context);
                          } else if (state is SignUpLoadedState) {
                            hideLoadingDialog(context: context);
                            showToastMessage(context: context, message: state.message);
                            PageNavigator.pop(context: context);
                          } else if (state is SignUpErrorState) {
                            hideLoadingDialog(context: context);
                            showToastMessage(context: context, message: state.message, isErrorMessage: true);
                          }
                        },
                        builder: (context, state) {
                          SignUpCubit cubit = BlocProvider.of<SignUpCubit>(context);
                          return Column(
                            children: [
                              BoldTextView(
                                  data: "Register to",
                                  textColor: AppColors.blackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800),
                              ImageView(
                                  imageUrl: AppImages.appLogoImage,
                                  height: MediaQuery.of(context).size.width / 4,
                                  width: MediaQuery.of(context).size.width / 4),
                              SemiBoldTextView(data: "Create your account", textColor: AppColors.greyColor),
                              TextFieldView(
                                  controller: cubit.firstNameController,
                                  label: "First Name",
                                  hint: "Enter your first name"),
                              TextFieldView(
                                  controller: cubit.lastNameController,
                                  label: "Last Name",
                                  hint: "Enter your last name"),
                              TextFieldView(
                                  controller: cubit.phoneNumberController,
                                  label: "Phone",
                                  hint: "Enter your phone number",
                                  textInputType: TextInputType.number,
                                  inputFormatters: allowOnlyNumbers),
                              TextFieldView(
                                  controller: cubit.emailController,
                                  label: "Email",
                                  hint: "Enter your email"),
                              TextFieldView(
                                  controller: cubit.passwordController,
                                  label: "Password",
                                  hint: "Enter your password"),
                              TextFieldView(
                                  controller: cubit.confirmPasswordController,
                                  label: "ConfirmPassword",
                                  hint: "Enter your password"),
                              ButtonView(
                                  title: "Register",
                                  bottomMargin: 30,
                                  onTap: () async {
                                    await cubit.validateAndSignUp(context: context);
                                  }),
                              RichText(
                                  text: TextSpan(
                                      text: "Already have an account? ",
                                      style: AppTextStyle.mediumTextStyle.copyWith(fontSize: 16),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: 'Sign In',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            hideKeyboard();
                                            PageNavigator.pop(context: context);
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
