import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/models/checkout_process/address_model.dart';
import 'package:zimozi_store/models/checkout_process/cart_details_model.dart';
import 'package:zimozi_store/screens/dashboard/dashboard_screen.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/checkout_process/bill_summary_card_view.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen(
      {super.key,
      required this.items,
      required this.isSuccessOrder,
      required this.address,
      this.paymentDetails});

  final bool isSuccessOrder;
  final AddressModel address;
  final Map<String, dynamic>? paymentDetails;
  final List<CartDetailsModel> items;

  @override
  Widget build(BuildContext context) {
    double getTotalPrice() {
      if (items.isEmpty) {
        return 0;
      } else {
        return items
            .map((CartDetailsModel e) => double.parse(
                ((e.cartModel.quantity ?? 0) * (e.productDataModel.discountedPrice ?? 0)).toString()))
            .toList()
            .reduce((value, element) => value + element);
      }
    }

    double getTaxAmount() {
      double itemPrice = getTotalPrice();
      return (itemPrice * 0.18);
    }

    double getDiscountAmount() {
      double itemPrice = getTotalPrice();
      double taxPrice = getTaxAmount();
      return (itemPrice + taxPrice) / 10;
    }

    double totalBillableAmount() {
      double itemPrice = getTotalPrice();
      double taxPrice = getTaxAmount();
      double discountPrice = getDiscountAmount();
      return (itemPrice + taxPrice) - discountPrice;
    }

    return Scaffold(
      body: Column(
        children: [
          AppBarView(title: "Order ${isSuccessOrder ? "Placed" : "Failed"}"),
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
                    data: isSuccessOrder
                        ? "Your order is placed.\n keep shopping with us."
                        : "Your order is failed to placed.\n Please try again.",
                    topPadding: 15,
                    bottomPadding: 25,
                    textAlign: TextAlign.center,
                    fontSize: 16,
                  )),
                  SemiBoldTextView(data: "Delivery Address", fontSize: 18, bottomPadding: 10),
                  MediumTextView(data: getFormattedAddress(address: address)),
                  SemiBoldTextView(data: "Bill Summary", fontSize: 18, topPadding: 20, bottomPadding: 10),
                  BillSummaryCardView(title: "Item total", value: "Rs.${getTotalPrice().toStringAsFixed(2)}"),
                  BillSummaryCardView(title: "TAX (18%)", value: "Rs.${getTaxAmount().toStringAsFixed(2)}"),
                  BillSummaryCardView(title: "Delivery Charge", value: "Free"),
                  BillSummaryCardView(
                      title: "Discounts (10%)",
                      value: "-Rs.${getDiscountAmount().toStringAsFixed(2)}",
                      valueColor: AppColors.greenColor),
                  BillSummaryCardView(
                      title: "Grand Total",
                      value: "Rs.${totalBillableAmount().toStringAsFixed(2)}",
                      valueColor: AppColors.orangeColor),
                  SemiBoldTextView(data: "Payment Summary", fontSize: 18, topPadding: 20, bottomPadding: 10),
                  BillSummaryCardView(title: "Type", value: "Credit Card"),
                  BillSummaryCardView(
                      title: "Reference Id",
                      value: (paymentDetails?["id"] ?? "--").toString(),
                      valueColor: AppColors.orangeColor),
                  BillSummaryCardView(
                      title: "Payment Status",
                      value: (paymentDetails?["status"] ?? "--").toString(),
                      valueColor: AppColors.orangeColor),
                  ButtonView(
                      title: "Go to Home",
                      topMargin: 40,
                      bottomMargin: 20,
                      onTap: () {
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
