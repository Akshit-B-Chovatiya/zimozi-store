import 'package:flutter/material.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
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
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
                spacing: 15,
                children: List.generate(3, (int index) {
                  return MyOrdersCarView();
                })),
          ))
        ],
      ),
    );
  }
}
