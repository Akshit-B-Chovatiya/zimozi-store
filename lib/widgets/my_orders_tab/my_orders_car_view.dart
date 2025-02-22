import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/models/orders/my_orders_model.dart';
import 'package:zimozi_store/widgets/checkout_process/bill_summary_card_view.dart';
import 'package:zimozi_store/widgets/common/divider_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class MyOrdersCarView extends StatelessWidget {
  const MyOrdersCarView({super.key, required this.order});

  final MyOrdersModel order;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.liteGreyColor)),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Expanded(
              child: MediumTextView(
                  data: "Order date", maxLine: 2, textOverflow: TextOverflow.ellipsis, fontSize: 12),
            ),
            MediumTextView(
                data: order.createdAt ?? "",
                maxLine: 2,
                textColor: AppColors.greyColor,
                textOverflow: TextOverflow.ellipsis,
                fontSize: 10)
          ]),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: MediumTextView(
                      data: "Payment Reference",
                      maxLine: 2,
                      textOverflow: TextOverflow.ellipsis,
                      fontSize: 12)),
              MediumTextView(
                  data: "#${order.paymentDetails?.id}",
                  maxLine: 2,
                  fontSize: 10,
                  textColor: AppColors.greyColor,
                  textOverflow: TextOverflow.ellipsis)
            ],
          ),
          DividerView(topMargin: 5, bottomMargin: 5),
          ...List.generate((order.items ?? []).length, (int index) {
            Item item = (order.items ?? [])[index];
            return BillSummaryCardView(
                title: "${item.quantity ?? 0} x ${item.name ?? ""}", value: "Rs. 100.00");
          }),
          DividerView(topMargin: 5, bottomMargin: 5),
          BillSummaryCardView(
              title: "Total",
              value: "Rs.${(order.totalAmount ?? 0).toStringAsFixed(2)}",
              valueColor: AppColors.orangeColor)
        ],
      ),
    );
  }
}
