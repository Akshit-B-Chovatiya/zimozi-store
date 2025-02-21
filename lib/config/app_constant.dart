import 'package:flutter/cupertino.dart';

class AppConstants {
  AppConstants._();

  ///GLOBAL DATA
  static const String appName = "Zimozi Store";
  static const String appVersion = "V : 1.0.0";
  static const ScrollPhysics scrollPhysics = ClampingScrollPhysics();
  static const bool isLogEnabled = true;
  static const String isLoggedIn = "IS-LOGGED-IN";
  static const String firebaseToken = "FIREBASE-TOKEN";
  static const double lineStrikethrough = 2.85;

  ///ROUTER KEY
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  ///FONT FAMILIES
  static const String manRopeFamily = "Man-Rope";
}
