import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/account/account_cubit.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/discover_tab/discover/discover_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/screens/dashboard/wishlist_screen.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';
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
              child: BlocProvider(
                  create: (context) => DiscoverCubit()..fetchAllProducts(),
                  child: BlocBuilder<DiscoverCubit, DiscoverState>(builder: (context, state) {
                    DiscoverCubit cubit = BlocProvider.of<DiscoverCubit>(context);
                    return state is DiscoverLoadingState
                        ? Center(child: LoadingView())
                        : state is DiscoverEmptyState
                            ? Center(
                                child: SemiBoldTextView(
                                    data: "No products found!", fontSize: 18, textColor: AppColors.redColor))
                            : BlocBuilder<AccountCubit, AccountState>(
                                builder: (context, state) {
                                  return SingleChildScrollView(
                                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                      child: SizedBox(
                                          width: MediaQuery.of(context).size.width - 30,
                                          child: Wrap(
                                              alignment: WrapAlignment.spaceBetween,
                                              runSpacing: 10,
                                              children: List.generate(cubit.allProducts.length, (int index) {
                                                return ProductCardView(
                                                    productModel: cubit.allProducts[index]);
                                              }))));
                                },
                              );
                  })))
        ],
      ),
    );
  }
}
