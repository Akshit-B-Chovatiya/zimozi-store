import 'package:flutter/cupertino.dart';

class PageNavigator {
  static Future<dynamic> pushPage(
      {required BuildContext context, required Widget page, Function()? onComplete}) {
    return Navigator.push(context, CupertinoPageRoute(builder: (BuildContext context) => page))
        .whenComplete(() {
      if (onComplete != null) {
        onComplete();
      }
    });
  }

  static Future<dynamic> pushAndRemoveUntilPage(
      {required BuildContext context, required Widget page, Function()? onComplete}) {
    return Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (BuildContext context) => page),
        (Route<dynamic> route) => false).whenComplete(() {
      if (onComplete != null) {
        onComplete();
      }
    });
  }

  static Future<dynamic> pushReplacementPage(
      {required BuildContext context, required Widget page, Function()? onComplete}) {
    return Navigator.pushReplacement(context, CupertinoPageRoute(builder: (BuildContext context) => page))
        .whenComplete(() {
      if (onComplete != null) {
        onComplete();
      }
    });
  }

  static void pop({required BuildContext context}) {
    return Navigator.of(context).pop();
  }
}
