import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_constant.dart';

class AppColors {
  AppColors._();

  ///HEX COLORS
  static const Color whiteColor = Color(0xffffffff);
  static const Color blackColor = Color(0xff000000);
  static const Color redColor = Color(0xffD30000);
  static const Color greenColor = Color(0xff008000);
  static const Color yellowColor = Color(0xffFFFF00);
  static const Color orangeColor = Color(0xffFFA500);
  static const Color greyColor = Color(0xff808080);
  static const Color liteGreyColor = Color(0xffD3D3D3);

  ///MATERIAL COLORS
  static const Color transparentColor = Colors.transparent;
  static const MaterialColor blueThemeColor = Colors.blue;

  ///GRADIENT COLORS
  static const LinearGradient appBackgroundLinearGradient = LinearGradient(
      colors: [AppColors.orangeColor, AppColors.orangeColor, AppColors.whiteColor, AppColors.whiteColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static const LinearGradient splashLinearGradient = LinearGradient(
      colors: [AppColors.orangeColor, AppColors.orangeColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  ///APP THEME
  static ThemeData appTheme = ThemeData(
      useMaterial3: true,
      primarySwatch: blueThemeColor,
      fontFamily: AppConstants.manRopeFamily,
      scaffoldBackgroundColor: AppColors.whiteColor,
      appBarTheme: const AppBarTheme(backgroundColor: AppColors.transparentColor),
      brightness: Brightness.light,
      splashColor: AppColors.transparentColor,
      highlightColor: Colors.transparent,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(backgroundColor: AppColors.whiteColor),
      bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.whiteColor));
}
