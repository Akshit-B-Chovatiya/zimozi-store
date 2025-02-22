import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/models/checkout_process/cart_details_model.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_product_service.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class BagProductCardView extends StatelessWidget {
  const BagProductCardView({super.key, required this.cartDetailsModel, required this.onUpdate});

  final CartDetailsModel cartDetailsModel;
  final Function(bool) onUpdate;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ImageView(
              imageUrl: cartDetailsModel.productDataModel.imageUrl ?? "",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MediumTextView(
                    data: cartDetailsModel.productDataModel.name ?? "",
                    maxLine: 2,
                    textOverflow: TextOverflow.ellipsis),
                Row(
                  children: [
                    BoldTextView(
                        data:
                            "Rs. ${(cartDetailsModel.productDataModel.discountedPrice ?? 0).toStringAsFixed(2)}",
                        fontSize: 16,
                        rightPadding: 10,
                        textColor: AppColors.orangeColor,
                        textOverflow: TextOverflow.ellipsis),
                    MediumTextView(
                        data: "Rs. ${(cartDetailsModel.productDataModel.price ?? 0).toStringAsFixed(2)}",
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
                          onPressed: () async {
                            int currentQuantity = cartDetailsModel.cartModel.quantity ?? 0;
                            currentQuantity--;
                            ProductModel productModel =
                                await FirebaseProductService.addOrRemoveProductToCartBag(
                                    context: context,
                                    productId: cartDetailsModel.cartModel.id ?? "",
                                    qty: currentQuantity);
                            onUpdate(productModel.isSuccess);
                          }),
                      SemiBoldTextView(
                          data: "${cartDetailsModel.cartModel.quantity ?? 0}",
                          fontSize: 20,
                          leftPadding: 10,
                          rightPadding: 10),
                      IconButtonView(
                          icon: Icons.add,
                          borderColor: AppColors.greenColor,
                          iconColor: AppColors.greenColor,
                          backgroundColor: AppColors.greenColor.withValues(alpha: (0.1)),
                          height: 20,
                          width: 20,
                          iconSize: 15,
                          onPressed: () async {
                            int currentQuantity = cartDetailsModel.cartModel.quantity ?? 0;
                            currentQuantity++;
                            ProductModel productModel =
                                await FirebaseProductService.addOrRemoveProductToCartBag(
                                    context: context,
                                    productId: cartDetailsModel.cartModel.id ?? "",
                                    qty: currentQuantity);
                            onUpdate(productModel.isSuccess);
                          }),
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
                          onTap: () async {
                            ProductModel productModel =
                                await FirebaseProductService.addOrRemoveProductToCartBag(
                                    context: context,
                                    productId: cartDetailsModel.cartModel.id ?? "",
                                    qty: -1);
                            onUpdate(productModel.isSuccess);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
