import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/dashboard/dashboards_cubit.dart';
import 'package:zimozi_store/blocs_and_cubits/splash_and_intro/splash/splash_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/screens/splash_and_intro/splash_screen.dart';
import 'package:zimozi_store/utils/services/configure_app_settings.dart';

void main() {
  configureAppSettings();
  runApp(const ZimoziStoreApp());
}

class ZimoziStoreApp extends StatelessWidget {
  const ZimoziStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          ///SPLASH SCREEN
          BlocProvider<SplashCubit>(create: (BuildContext _) => SplashCubit()),

          ///DASHBOARD SCREEN
          BlocProvider<DashboardsCubit>(create: (BuildContext _) => DashboardsCubit()),
        ],
        child: MaterialApp(
            title: 'Zimozi Store',
            theme: AppColors.appTheme,
            debugShowCheckedModeBanner: false,
            navigatorKey: AppConstants.navigatorKey,
            scrollBehavior: CupertinoScrollBehavior(),
            builder: (context, child) {
              return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling), child: child!);
            },
            home: const SplashScreen()));
  }
}
