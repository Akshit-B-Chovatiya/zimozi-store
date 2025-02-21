import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/splash_and_intro/splash/splash_cubit.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashCubit>(AppConstants.navigatorKey.currentContext ?? context)
        .initPreferences(context: AppConstants.navigatorKey.currentContext ?? context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ImageView(
          imageUrl: AppImages.appLogoImage,
          height: MediaQuery.of(context).size.width / 2,
          width: MediaQuery.of(context).size.width / 2),
    ));
  }
}
