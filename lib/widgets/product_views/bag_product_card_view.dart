import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class BagProductCardView extends StatelessWidget {
  const BagProductCardView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: AppColors.greyColor.withValues(alpha: (0.2)), blurRadius: 10, spreadRadius: 10)
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageView(
                  imageUrl: productModel.imageLink ?? "",
                  isAsset: false,
                  boxFit: BoxFit.fill,
                  width: (MediaQuery.of(context).size.width / 3.5),
                  height: (MediaQuery.of(context).size.width / 3.5)),
            ),
            SizedBox(width: 15),
            Expanded(
              child: SizedBox(
                height: (MediaQuery.of(context).size.width / 3.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MediumTextView(
                        data: productModel.title ?? "", maxLine: 2, textOverflow: TextOverflow.ellipsis),
                    Row(
                      children: [
                        BoldTextView(
                            data: "Rs. ${(productModel.newPrice ?? 0).toStringAsFixed(0)}/-",
                            fontSize: 16,
                            rightPadding: 10,
                            textColor: AppColors.orangeColor,
                            textOverflow: TextOverflow.ellipsis),
                        MediumTextView(
                            data: "Rs. ${(productModel.oldPrice ?? 0).toStringAsFixed(0)}/-",
                            fontSize: 13,
                            textColor: AppColors.greyColor,
                            textDecoration: TextDecoration.lineThrough,
                            textOverflow: TextOverflow.ellipsis)
                      ],
                    ),
                    Center(
                      child: Row(
                        children: [
                          IconButtonView(
                              icon: Icons.remove,
                              borderColor: AppColors.redColor,
                              iconColor: AppColors.redColor,
                              backgroundColor: AppColors.redColor.withValues(alpha: (0.2)),
                              height: 20,
                              width: 20,
                              iconSize: 15,
                              onPressed: () {}),
                          SemiBoldTextView(data: "1", fontSize: 20, leftPadding: 10, rightPadding: 10),
                          IconButtonView(
                              icon: Icons.add,
                              borderColor: AppColors.greenColor,
                              iconColor: AppColors.greenColor,
                              backgroundColor: AppColors.greenColor.withValues(alpha: (0.1)),
                              height: 20,
                              width: 20,
                              iconSize: 15,
                              onPressed: () {}),
                          Spacer(),
                          ButtonView(
                              title: "Remove",
                              textSize: 12,
                              topPadding: 5,
                              bottomPadding: 5,
                              bottomMargin: 0,
                              topMargin: 0,
                              buttonColor: AppColors.redColor.withValues(alpha: (0.1)),
                              borderColor: AppColors.redColor,
                              textColor: AppColors.redColor,
                              width: MediaQuery.of(context).size.width / 5,
                              onTap: () {}),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
