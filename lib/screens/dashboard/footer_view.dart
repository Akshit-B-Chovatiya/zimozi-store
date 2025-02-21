import 'package:flutter/material.dart';
import 'package:zimozi_store/blocs_and_cubits/dashboard/dashboards_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/widgets/dashboard/bottom_bar_icon_view.dart';

class DashboardBottomBarView extends StatelessWidget {
  const DashboardBottomBarView({super.key, required this.cubit});

  final DashboardsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.liteGreyColor))),
        child: Row(
          children: [
            Expanded(
                child: BottomBarIconView(
                    iconPath: AppImages.discoverIcon,
                    title: "Discover",
                    isSelected: cubit.currentTabIndex == 0,
                    onPressed: () {
                      cubit.changeTab(0);
                    })),
            Expanded(
                child: BottomBarIconView(
                    iconPath: AppImages.myOrderIcon,
                    title: "My Orders",
                    isSelected: cubit.currentTabIndex == 1,
                    onPressed: () {
                      cubit.changeTab(1);
                    })),
            Expanded(
                child: BottomBarIconView(
                    iconPath: AppImages.shoppingCartIcon,
                    title: "Bag",
                    isSelected: cubit.currentTabIndex == 2,
                    onPressed: () {
                      cubit.changeTab(2);
                    })),
            Expanded(
                child: BottomBarIconView(
                    iconPath: AppImages.accountIcon,
                    title: "Account",
                    isSelected: cubit.currentTabIndex == 3,
                    onPressed: () {
                      cubit.changeTab(3);
                    })),
          ],
        ),
      ),
    );
  }
}
