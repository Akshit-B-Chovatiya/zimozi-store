import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:zimozi_store/config/app_constant.dart';

void showLogs({required String message}) {
  if (AppConstants.isLogEnabled && kDebugMode) {
    log("!! $message !!");
  }
}
