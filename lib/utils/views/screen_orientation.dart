import 'package:flutter/services.dart';

Future<void> setScreenOrientationPortrait() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}
