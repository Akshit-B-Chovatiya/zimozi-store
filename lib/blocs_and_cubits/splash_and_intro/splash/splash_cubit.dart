import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/screens/authetications/sign_in_screen.dart';
import 'package:zimozi_store/screens/dashboard/dashboard_screen.dart';
import 'package:zimozi_store/utils/storage_services/shared_preferences.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitialState());

  Future<void> initPreferences({required BuildContext context}) async {
    bool? isLoggedIn = await LocalStorage.getBool(key: AppConstants.isLoggedIn);
    Future.delayed(const Duration(seconds: 2), () {
      if (isLoggedIn == true) {
        PageNavigator.pushAndRemoveUntilPage(
            context: AppConstants.navigatorKey.currentContext ?? context, page: const DashboardScreen());
      } else {
        PageNavigator.pushAndRemoveUntilPage(
            context: AppConstants.navigatorKey.currentContext ?? context, page: const SignInScreen());
      }
    });
  }
}
