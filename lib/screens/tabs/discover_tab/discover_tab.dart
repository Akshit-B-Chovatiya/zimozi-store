import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/screens/dashboard/wishlist_screen.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/product_views/product_card_view.dart';

class DiscoverTab extends StatelessWidget {
  const DiscoverTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarView(
              title: "Discover",
              suffixIcon: AppImages.unFavouriteIcon,
              onSuffixPressed: () {
                PageNavigator.pushPage(context: context, page: WishlistScreen());
              }),
          Expanded(
              child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 30,
              child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runSpacing: 10,
                  children: List.generate(5, (int index) {
                    return ProductCardView(
                        productModel: ProductModel(
                            title: "Product title in two line to check align and overflow of size",
                            imageLink:
                                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                            isFavourite: false,
                            newPrice: 299,
                            oldPrice: 350));
                  })),
            ),
          ))
        ],
      ),
    );
  }
}
