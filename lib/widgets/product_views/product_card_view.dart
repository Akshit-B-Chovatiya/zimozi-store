import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/account/account_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_product_service.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/image_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';

class ProductCardView extends StatelessWidget {
  const ProductCardView({super.key, required this.productModel});

  final ProductDataModel productModel;

  @override
  Widget build(BuildContext context) {
    AccountCubit accountCubit = BlocProvider.of<AccountCubit>(context);
    List<String> wishList = accountCubit.zimoziUser?.wishlist ?? [];
    List<String> cartList = (accountCubit.zimoziUser?.cart ?? []).map((e) => e.id ?? "").toList();
    return Container(
      width: (MediaQuery.of(context).size.width / 2) - 22.5,
      decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.liteGreyColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.liteGreyColor)),
                  child: ImageView(
                      imageUrl: productModel.imageUrl ?? "",
                      isAsset: false,
                      boxFit: BoxFit.fill,
                      width: (MediaQuery.of(context).size.width / 2) - 22.5,
                      height: (MediaQuery.of(context).size.width / 2) - 22.5),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 10, right: 10),
                  child: InkWell(
                    onTap: () async {
                      await FirebaseProductService.updateWishlistProducts(
                          context: context, productId: productModel.id ?? "");
                    },
                    child: ImageView(
                        imageUrl: wishList.contains(productModel.id ?? "")
                            ? AppImages.favouriteIcon
                            : AppImages.unFavouriteIcon,
                        isSVG: true),
                  )),
            ],
          ),
          MediumTextView(
              data: "${productModel.name ?? " "}\n",
              maxLine: 2,
              topPadding: 5,
              leftPadding: 5,
              rightPadding: 5,
              textOverflow: TextOverflow.ellipsis),
          Container(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MediumTextView(
                          data: "Rs. ${(productModel.price ?? 0).toStringAsFixed(2)}",
                          fontSize: 12,
                          textColor: AppColors.greyColor,
                          textDecoration: TextDecoration.lineThrough,
                          textOverflow: TextOverflow.ellipsis),
                      BoldTextView(
                          data: "Rs. ${(productModel.discountedPrice ?? 0).toStringAsFixed(2)}",
                          fontSize: 14,
                          textColor: AppColors.orangeColor,
                          textOverflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
                IconButtonView(
                    icon: cartList.contains(productModel.id ?? "")
                        ? Icons.remove_shopping_cart_rounded
                        : Icons.add_shopping_cart_rounded,
                    height: 30,
                    width: 30,
                    iconSize: 18,
                    backgroundColor: cartList.contains(productModel.id ?? "")
                        ? AppColors.redColor.withValues(alpha: 0.1)
                        : AppColors.greenColor.withValues(alpha: 0.1),
                    borderColor:
                        cartList.contains(productModel.id ?? "") ? AppColors.redColor : AppColors.greenColor,
                    iconColor:
                        cartList.contains(productModel.id ?? "") ? AppColors.redColor : AppColors.greenColor,
                    onPressed: () async {
                      await FirebaseProductService.addOrRemoveProductToCartBag(
                          context: context, productId: productModel.id ?? "", qty: -1);
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
