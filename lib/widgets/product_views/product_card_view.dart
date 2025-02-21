import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 22.5,
      decoration: BoxDecoration(color: AppColors.whiteColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: ImageView(
                    imageUrl: productModel.imageLink ?? "",
                    isAsset: false,
                    boxFit: BoxFit.fill,
                    width: (MediaQuery.of(context).size.width / 2) - 22.5,
                    height: (MediaQuery.of(context).size.width / 2)),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  child: ImageView(
                    imageUrl: productModel.isFavourite == true
                        ? AppImages.favouriteIcon
                        : AppImages.unFavouriteIcon,
                    isSVG: true,
                  )),
            ],
          ),
          MediumTextView(
              data: productModel.title ?? "",
              maxLine: 2,
              topPadding: 5,
              leftPadding: 5,
              rightPadding: 5,
              textOverflow: TextOverflow.ellipsis),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Row(
              children: [
                BoldTextView(
                    data: "Rs. ${(productModel.newPrice ?? 0).toStringAsFixed(2)}",
                    maxLine: 2,
                    fontSize: 16,
                    rightPadding: 10,
                    textColor: AppColors.orangeColor,
                    textOverflow: TextOverflow.ellipsis),
                MediumTextView(
                    data: "Rs. ${(productModel.oldPrice ?? 0).toStringAsFixed(2)}",
                    maxLine: 2,
                    fontSize: 12,
                    textColor: AppColors.greyColor,
                    textDecoration: TextDecoration.lineThrough,
                    textOverflow: TextOverflow.ellipsis)
              ],
            ),
          ),
          Center(
            child: ButtonView(
                title: "Add To Bag",
                textSize: 12,
                topMargin: 0,
                bottomMargin: 10,
                topPadding: 5,
                bottomPadding: 5,
                width: MediaQuery.of(context).size.width / 4,
                onTap: () {}),
          )
        ],
      ),
    );
  }
}
