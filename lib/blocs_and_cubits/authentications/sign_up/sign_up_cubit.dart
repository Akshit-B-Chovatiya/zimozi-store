import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimozi_store/utils/services/keyboard_services.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitialState());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> validateAndSignUp({required BuildContext context}) async {
    emit(SignUpLoadingState());
    if (firstNameController.text.trim().isEmpty) {
      emit(SignUpErrorState(message: "Please enter your first name!"));
    } else if (lastNameController.text.trim().isEmpty) {
      emit(SignUpErrorState(message: "Please enter your last name!"));
    } else if (phoneNumberController.text.trim().isEmpty) {
      emit(SignUpErrorState(message: "Please enter your mobile number!"));
    } else if (emailController.text.trim().isEmpty) {
      emit(SignUpErrorState(message: "Please enter your email address!"));
    } else if (isValidEmail(email: emailController.text.trim()) == false) {
      emit(SignUpErrorState(message: "Please enter valid email address!"));
    } else if (passwordController.text.trim().isEmpty) {
      emit(SignUpErrorState(message: "Please enter your password!"));
    } else if (confirmPasswordController.text.trim().isEmpty) {
      emit(SignUpErrorState(message: "Please enter confirmation password!"));
    } else if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      emit(SignUpErrorState(message: "Password & Confirm password are must be same!"));
    } else {
      hideKeyboard();
      emit(SignUpLoadingState());
      Future.delayed(const Duration(seconds: 2), () {
        emit(SignUpLoadedState(message: "Registered successfully!"));
        if (context.mounted) {
          PageNavigator.pop(context: context);
        }
      });
    }
  }
}
