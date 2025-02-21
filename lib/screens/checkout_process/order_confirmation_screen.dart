import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/dashboard/dashboards_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/checkout_process/address_model.dart';
import 'package:zimozi_store/screens/dashboard/dashboard_screen.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/checkout_process/bill_summary_card_view.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key, required this.isSuccessOrder, required this.address});

  final bool isSuccessOrder;
  final AddressModel address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarView(title: "Order Placed"),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Center(
                      child:
                          Icon(Icons.check_circle_outline_rounded, size: 50, color: AppColors.orangeColor)),
                  Center(
                      child: MediumTextView(
                    data: "Your order is placed.\n keep shopping with us.",
                    topPadding: 15,
                    bottomPadding: 25,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                  )),
                  SemiBoldTextView(data: "Delivery Address", fontSize: 18, bottomPadding: 10),
                  MediumTextView(data: getFormattedAddress(address: address)),
                  SemiBoldTextView(data: "Bill Summary", fontSize: 18, topPadding: 20, bottomPadding: 10),
                  BillSummaryCardView(title: "Item total", value: "Rs. 500.00"),
                  BillSummaryCardView(title: "TAX (10%)", value: "Rs. 50.00"),
                  BillSummaryCardView(title: "Delivery Charge", value: "free"),
                  BillSummaryCardView(title: "Discounts", value: "Rs. 0.00"),
                  BillSummaryCardView(
                      title: "Grand Total", value: "Rs. 580.00", valueColor: AppColors.orangeColor),
                  SemiBoldTextView(data: "Payment Summary", fontSize: 18, topPadding: 20, bottomPadding: 10),
                  BillSummaryCardView(title: "Type", value: "Credit Card"),
                  BillSummaryCardView(
                      title: "Reference Id", value: "1523659875", valueColor: AppColors.orangeColor),
                  ButtonView(
                      title: "Go to Home",
                      topMargin: 40,
                      bottomMargin: 20,
                      onTap: () {
                        BlocProvider.of<DashboardsCubit>(AppConstants.navigatorKey.currentContext ?? context)
                            .changeTab(0);
                        PageNavigator.pushAndRemoveUntilPage(context: context, page: DashboardScreen());
                      })
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
