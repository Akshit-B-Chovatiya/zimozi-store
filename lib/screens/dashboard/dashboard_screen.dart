import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/dashboard/dashboards_cubit.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/account/account_cubit.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/screens/dashboard/footer_view.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    BlocProvider.of<DashboardsCubit>(AppConstants.navigatorKey.currentContext ?? context).changeTab(0);
    BlocProvider.of<AccountCubit>(AppConstants.navigatorKey.currentContext ?? context).getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardsCubit, DashboardsState>(
        buildWhen: (DashboardsState previous, DashboardsState current) {
      return current is DashboardsTabChangedState;
    }, builder: (context, state) {
      DashboardsCubit cubit = BlocProvider.of<DashboardsCubit>(context);
      return Scaffold(
          body: PopScope(
              canPop: false,
              onPopInvoked: (bool v) {
                if (cubit.currentTabIndex != 0) {
                  cubit.changeTab(0);
                } else {
                  exit(0);
                }
              },
              child: cubit.getTabView()),
          bottomNavigationBar: DashboardBottomBarView(cubit: cubit));
    });
  }
}
