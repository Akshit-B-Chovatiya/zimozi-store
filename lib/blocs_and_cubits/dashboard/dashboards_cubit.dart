import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/screens/tabs/account_tab/account_tab.dart';
import 'package:zimozi_store/screens/tabs/cart_tab/cart_tab.dart';
import 'package:zimozi_store/screens/tabs/discover_tab/discover_tab.dart';
import 'package:zimozi_store/screens/tabs/my_orders_tab/my_orders_tab.dart';

part 'dashboards_state.dart';

class DashboardsCubit extends Cubit<DashboardsState> {
  DashboardsCubit() : super(DashboardsInitialState());

  int currentTabIndex = 0;

  void changeTab(int index) {
    if (index != currentTabIndex) {
      emit(DashboardsInitialState());
      currentTabIndex = index;
      emit(DashboardsTabChangedState());
    }
  }

  Widget getTabView() {
    switch (currentTabIndex) {
      case 0:
        return DiscoverTab();
      case 1:
        return MyOrdersTab();
      case 2:
        return CartTab();
      case 3:
        return AccountTab();
      default:
        return Container(color: AppColors.whiteColor);
    }
  }
}
