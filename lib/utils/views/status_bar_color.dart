import 'package:flutter/services.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/utils/common/log_services.dart';

Future<void> changeStatusColor() async {
  showLogs(message: "START TO SET STATUS BAR COLOR");
  try {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.transparentColor,
      systemNavigationBarColor: AppColors.transparentColor,
      systemStatusBarContrastEnforced: true,
      // statusBarIconBrightness: Brightness.dark,
      // statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.transparentColor,
    ));
    showLogs(message: "STATUS BAR COLOR SET");
  } on PlatformException catch (e) {
    showLogs(message: "STATUS BAR COLOR ERROR : ${e.toString()}");
  }
}
