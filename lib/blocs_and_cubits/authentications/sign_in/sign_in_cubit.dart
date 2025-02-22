import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/authentication/authentication_model.dart';
import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_autehntication_service.dart';
import 'package:zimozi_store/utils/services/keyboard_services.dart';
import 'package:zimozi_store/utils/storage_services/shared_preferences.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitialState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void clearForm() {
    emit(SignInInitialState());
    emailController.clear();
    passwordController.clear();
    hideKeyboard();
    emit(SignInUpdatedState());
  }

  Future<void> validateAndSignIn({required BuildContext context}) async {
    emit(SignInLoadingState());
    if (emailController.text.trim().isEmpty) {
      emit(SignInErrorState(message: "Please enter registered email address!"));
    } else if (isValidEmail(email: emailController.text.trim()) == false) {
      emit(SignInErrorState(message: "Please enter valid email address!"));
    } else if (passwordController.text.trim().isEmpty) {
      emit(SignInErrorState(message: "Please enter your password!"));
    } else {
      hideKeyboard();
      emit(SignInLoadingState());
      AuthenticationModel authenticationModel = await FirebaseAuthService.login(
          email: emailController.text.trim(), password: passwordController.text.trim());
      if (authenticationModel.isSuccess) {
        await LocalStorage.setString(key: AppConstants.userId, value: authenticationModel.user?.uid ?? "");
        await LocalStorage.setBool(key: AppConstants.isLoggedIn, value: true);
        UserModel userModel =
            await FirebaseAuthService.getUserData(userId: authenticationModel.user?.uid ?? "");
        await LocalStorage.setString(
            key: AppConstants.userDetails, value: json.encode(userModel.user?.toJson()));
        emit(SignInLoadedState(message: authenticationModel.message));
      } else {
        emit(SignInErrorState(message: authenticationModel.message));
      }
    }
  }
}
