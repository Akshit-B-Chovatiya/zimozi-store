import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zimozi_store/models/authentication/authentication_model.dart';
import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_autehntication_service.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitialState());

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  File? selectedProfileImage;
  String? networkProfileImage;

  void setPrefillData({required ZimoziUser userDetails}) async {
    emit(EditProfileInitialState());
    networkProfileImage = userDetails.profileImage;
    firstNameController.text = userDetails.firstName ?? "";
    lastNameController.text = userDetails.lastName ?? "";
    emailController.text = userDetails.emailAddress ?? "";
    phoneNumberController.text = userDetails.phoneNumber ?? "";
    emit(EditProfileUpdatedState());
  }

  Future<void> validateAndUpdateDetails({required BuildContext context}) async {
    emit(EditProfileLoadingState());
    if (firstNameController.text.trim().isEmpty) {
      emit(EditProfileErrorState(message: "Please enter your first name!"));
    } else if (lastNameController.text.trim().isEmpty) {
      emit(EditProfileErrorState(message: "Please enter your last name!"));
    } else if (phoneNumberController.text.trim().isEmpty) {
      emit(EditProfileErrorState(message: "Please enter your mobile number!"));
    } else {
      AuthenticationModel authenticationModel = await FirebaseAuthService.updateUserDetails(
          context: context,
          zimoziUser: ZimoziUser(
              firstName: firstNameController.text.trim(),
              lastName: lastNameController.text.trim(),
              emailAddress: emailController.text.trim(),
              phoneNumber: phoneNumberController.text.trim(),
              profileImage: networkProfileImage),
          profileImage: selectedProfileImage);

      if (authenticationModel.isSuccess) {
        emit(EditProfileLoadedState(message: authenticationModel.message));
      } else {
        emit(EditProfileErrorState(message: authenticationModel.message));
      }
    }
  }
}
