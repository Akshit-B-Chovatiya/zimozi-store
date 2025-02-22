import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/my_orders_tab/my_orders_tab_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';
import 'package:zimozi_store/widgets/my_orders_tab/my_orders_car_view.dart';

class MyOrdersTab extends StatelessWidget {
  const MyOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarView(title: "My Orders"),
          Expanded(
              child: BlocProvider(
            create: (context) => MyOrdersTabCubit()..getAllOrders(),
            child: BlocBuilder<MyOrdersTabCubit, MyOrdersTabState>(
              builder: (context, state) {
                MyOrdersTabCubit cubit = BlocProvider.of<MyOrdersTabCubit>(context);
                return state is MyOrdersTabLoadingState
                    ? Center(child: LoadingView())
                    : state is MyOrdersTabEmptyState
                        ? Center(
                            child: SemiBoldTextView(
                                data: "No orders found!", fontSize: 18, textColor: AppColors.redColor))
                        : SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                            child: Column(
                                spacing: 15,
                                children: List.generate(cubit.allOrders.length, (int index) {
                                  return MyOrdersCarView(order: cubit.allOrders[index]);
                                })));
              },
            ),
          ))
        ],
      ),
    );
  }
}
