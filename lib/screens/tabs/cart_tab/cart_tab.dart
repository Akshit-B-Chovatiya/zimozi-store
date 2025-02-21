import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/screens/checkout_process/checkout_screen.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';
import 'package:zimozi_store/widgets/product_views/bag_product_card_view.dart';

class CartTab extends StatelessWidget {
  const CartTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarView(title: "Bag"),
          Expanded(
              child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                  child: Column(spacing: 15, children: [
                    ...List.generate(3, (int index) {
                      return BagProductCardView(
                        productModel: ProductModel(
                            title: "Product title in two line to check align and overflow of size",
                            imageLink:
                                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                            isFavourite: true,
                            newPrice: 299,
                            oldPrice: 350),
                      );
                    }),
                  ]),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: AppColors.liteGreyColor)),
                    color: AppColors.yellowColor.withValues(alpha: (0.1))),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldTextView(data: "Rs500.00", fontSize: 18, textColor: AppColors.orangeColor),
                          RegularTextView(data: "Total", textColor: AppColors.greyColor)
                        ],
                      ),
                    ),
                    ButtonView(
                        title: "Checkout",
                        width: MediaQuery.of(context).size.width / 4,
                        topPadding: 6,
                        bottomPadding: 6,
                        bottomMargin: 0,
                        textSize: 13,
                        topMargin: 0,
                        onTap: () {
                          PageNavigator.pushPage(context: context, page: CheckoutScreen());
                        })
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
