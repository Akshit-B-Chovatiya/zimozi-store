import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_autehntication_service.dart';
import 'package:zimozi_store/utils/storage_services/shared_preferences.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitialState());

  ZimoziUser? zimoziUser;

  Future<void> getUserDetails() async {
    emit(AccountLoadingState());
    String? userId = await LocalStorage.getString(key: AppConstants.userId);
    String? userDetails = await LocalStorage.getString(key: AppConstants.userDetails);
    if (userId != null && userId.isNotEmpty) {
      if (userDetails != null) {
        zimoziUser = ZimoziUser.fromJson(json.decode(userDetails));
        emit(AccountLoadedState());
      } else {
        UserModel userModel = await FirebaseAuthService.getUserData(userId: userId);
        if (userModel.isSuccess) {
          zimoziUser = userModel.user;
          await LocalStorage.setString(
              key: AppConstants.userDetails, value: json.encode(userModel.user?.toJson()));
          emit(AccountLoadedState());
        } else {
          emit(AccountErrorState(message: userModel.message));
        }
      }
    } else {
      emit(AccountErrorState(message: "User details not found!"));
    }
  }
}
