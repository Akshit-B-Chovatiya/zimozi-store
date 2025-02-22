import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:zimozi_store/models/authentication/authentication_model.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_autehntication_service.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(ForgotPasswordInitialState());

  final TextEditingController emailController = TextEditingController();

  Future<void> validateAndSendResetPasswordLinkToMail() async {
    emit(ForgotPasswordLoadingState());
    if (emailController.text.trim().isEmpty) {
      emit(ForgotPasswordErrorState(message: "Please enter registered email address!"));
    } else if (isValidEmail(email: emailController.text.trim()) == false) {
      emit(ForgotPasswordErrorState(message: "Please enter valid email address!"));
    } else {
      AuthenticationModel authenticationModel =
          await FirebaseAuthService.sendPasswordResetLinkToEmail(email: emailController.text.trim());
      if (authenticationModel.isSuccess) {
        emit(ForgotPasswordLoadedState(message: authenticationModel.message));
      } else {
        emit(ForgotPasswordErrorState(message: authenticationModel.message));
      }
    }
  }
}
