import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/widgets/checkout_process/bill_summary_card_view.dart';
import 'package:zimozi_store/widgets/common/divider_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class MyOrdersCarView extends StatelessWidget {
  const MyOrdersCarView({super.key});

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
          Row(
            children: [
              Expanded(
                child: MediumTextView(
                    data: "14 - Feb - 2025", maxLine: 2, topPadding: 5, textOverflow: TextOverflow.ellipsis),
              ),
              MediumTextView(
                  data: "#123",
                  maxLine: 2,
                  topPadding: 5,
                  textColor: AppColors.greyColor,
                  textOverflow: TextOverflow.ellipsis),
            ],
          ),
          DividerView(topMargin: 5, bottomMargin: 5),
          ...List.generate(5, (int index) {
            return BillSummaryCardView(title: "2 x Iten ${index + 1}", value: "Rs. 100.00");
          }),
          DividerView(topMargin: 5, bottomMargin: 5),
          BillSummaryCardView(title: "Total", value: "Rs. 100.00", valueColor: AppColors.orangeColor)
        ],
      ),
    );
  }
}
