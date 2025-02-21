import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimozi_store/utils/services/keyboard_services.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitialState());

  final TextEditingController emailController = TextEditingController(text: "test@gmail.com");
  final TextEditingController passwordController = TextEditingController(text: "1234");

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
      Future.delayed(const Duration(seconds: 2), () {
        emit(SignInLoadedState(message: "Sign in successfully!"));
      });
    }
  }
}
