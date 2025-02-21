import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class BillSummaryCardView extends StatelessWidget {
  const BillSummaryCardView({super.key,
  required this.title,
  required this.value,
  this.valueColor});

  final String title;
  final String value;
  final Color? valueColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SemiBoldTextView(data: title, textColor: AppColors.greyColor)),
        SemiBoldTextView(data: value,textColor: valueColor)
      ],
    );
  }
}
