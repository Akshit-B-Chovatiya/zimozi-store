import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.size = 60, this.color = AppColors.orangeColor});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(child: SpinKitFadingCircle(color: color, size: size));
  }
}

showLoadingDialog({required BuildContext context}) {
  showDialog(
      barrierDismissible: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return const Center(child: LoadingView());
      });
}

hideLoadingDialog({required BuildContext context}) {
  PageNavigator.pop(context: context);
}
