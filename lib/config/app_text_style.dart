import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_constant.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle lightTextStyle = const TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w300,
      fontFamily: AppConstants.manRopeFamily);

  static TextStyle regularTextStyle = const TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: AppConstants.manRopeFamily);

  static TextStyle mediumTextStyle = const TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: AppConstants.manRopeFamily);

  static TextStyle semiBoldTestStyle = const TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: AppConstants.manRopeFamily);

  static TextStyle boldTextStyle = const TextStyle(
      color: AppColors.blackColor,
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: AppConstants.manRopeFamily);
}
