import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class CheckoutProductCardView extends StatelessWidget {
  const CheckoutProductCardView({super.key, required this.productModel, required this.quantity});

  final ProductDataModel productModel;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageView(
              imageUrl: productModel.imageUrl ?? "",
              isAsset: false,
              boxFit: BoxFit.fill,
              width: 50,
              height: 50),
        ),
        SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediumTextView(
                data: productModel.name ?? "",
                maxLine: 1,
                textOverflow: TextOverflow.ellipsis,
                bottomPadding: 5,
              ),
              Row(
                children: [
                  BoldTextView(
                      data: "Rs. ${(productModel.discountedPrice ?? 0).toStringAsFixed(2)}",
                      fontSize: 16,
                      rightPadding: 10,
                      textColor: AppColors.orangeColor,
                      textOverflow: TextOverflow.ellipsis),
                  MediumTextView(
                      data: "Rs. ${(productModel.price ?? 0).toStringAsFixed(2)}",
                      fontSize: 13,
                      textColor: AppColors.greyColor,
                      textDecoration: TextDecoration.lineThrough,
                      textOverflow: TextOverflow.ellipsis),
                  Spacer(),
                  MediumTextView(
                      data: "Qty : ",
                      fontSize: 13,
                      textColor: AppColors.greyColor,
                      textOverflow: TextOverflow.ellipsis),
                  MediumTextView(
                      data: "x$quantity",
                      fontSize: 13,
                      textColor: AppColors.blackColor,
                      textOverflow: TextOverflow.ellipsis)
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
