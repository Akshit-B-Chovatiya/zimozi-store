import 'package:flutter/material.dart';
import 'package:zimozi_store/utils/notification_service/notification_service.dart';
import 'package:zimozi_store/utils/views/screen_orientation.dart';
import 'package:zimozi_store/utils/views/status_bar_color.dart';

Future configureAppSettings() async {
  WidgetsFlutterBinding.ensureInitialized();
  await changeStatusColor();
  await setScreenOrientationPortrait();
  await NotificationService.initFirebase();
}
