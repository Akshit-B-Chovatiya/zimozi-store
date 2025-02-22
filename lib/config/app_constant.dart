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

  ///FIREBASE DETAILS
  static const String userId = "USER_ID";
  static const String userDetails = "USER-DETAILS";

  static const String stripePublishableKey =
      "pk_test_51MlSLRSH8dA9zobqj7d1YsKI20JYR4I8JFsC87129uHfXlX6U8XnDMgLLgj4Dxdc2LWK3wHR3HmLXMnn1BzUq7Uu00zscYhwIm";
  static const String stripeSecretKey =
      "sk_test_51MlSLRSH8dA9zobqVcCYgEKgH7EZjwYvNos4y3vkjuPLwA1mBi9fAal7sYL5JFllILsHpPobPcwyqpDmadOg4wKS00QhKKwfyT";

}

class FirebaseKeys {
  FirebaseKeys._();

  ///DATABASES
  static const String users = "users";
  static const String products = "products";
  static const String orders = "orders";
}
