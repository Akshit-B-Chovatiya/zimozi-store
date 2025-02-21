import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController verificationCodeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newConfirmPasswordController = TextEditingController();

  bool isOTPSent = false;
  bool isOTPVerified = false;

  Future<void> validateAndDoProcessForForgotPassword({required BuildContext context}) async {
    if (isOTPVerified) {
      validateAndUpdatePassword(context: context);
    } else if (isOTPSent) {
      await validateAndVerifyOTP();
    } else {
      await validateAndSendOTP();
    }
  }

  Future<void> validateAndSendOTP() async {
    emit(ForgotPasswordLoadingState());
    if (emailController.text.trim().isEmpty) {
      isOTPSent = false;
      isOTPVerified = false;
      emit(ForgotPasswordErrorState(message: "Please enter registered email address!"));
    } else if (isValidEmail(email: emailController.text.trim()) == false) {
      isOTPSent = false;
      isOTPVerified = false;
      emit(ForgotPasswordErrorState(message: "Please enter valid email address!"));
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        isOTPSent = true;
        isOTPVerified = false;
        emit(ForgotPasswordLoadedState(message: "Verification code sent to ${emailController.text}!"));
      });
    }
  }

  Future<void> validateAndVerifyOTP() async {
    emit(ForgotPasswordLoadingState());
    if (verificationCodeController.text.trim().isEmpty) {
      isOTPSent = true;
      isOTPVerified = false;
      emit(ForgotPasswordErrorState(message: "Please enter verification code!"));
    } else if (verificationCodeController.text.trim().toString().length != 6) {
      isOTPSent = true;
      isOTPVerified = false;
      emit(ForgotPasswordErrorState(message: "Please enter valid verification code!"));
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        isOTPSent = true;
        isOTPVerified = true;
        emit(ForgotPasswordLoadedState(message: "Code is verified!"));
      });
    }
  }

  Future<void> validateAndUpdatePassword({required BuildContext context}) async {
    emit(ForgotPasswordLoadingState());
    if (newPasswordController.text.trim().isEmpty) {
      isOTPSent = true;
      isOTPVerified = true;
      emit(ForgotPasswordErrorState(message: "Please enter new password!"));
    } else if (newConfirmPasswordController.text.trim().isEmpty) {
      isOTPSent = true;
      isOTPVerified = true;
      emit(ForgotPasswordErrorState(message: "Please enter confirmation password!"));
    } else if (newPasswordController.text.trim() != newConfirmPasswordController.text.trim()) {
      isOTPSent = true;
      isOTPVerified = true;
      emit(ForgotPasswordErrorState(message: "New password & Confirmation password are must be same!"));
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        isOTPSent = true;
        isOTPVerified = true;
        emit(ForgotPasswordLoadedState(message: "Password updated successfully!"));
        if (context.mounted) {
          PageNavigator.pop(context: context);
        }
      });
    }
  }
}
