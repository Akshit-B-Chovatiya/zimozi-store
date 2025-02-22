import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/account/account_cubit.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/bag_tab/cart/cart_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/screens/checkout_process/checkout_screen.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
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
          Expanded(child: BlocBuilder<AccountCubit, AccountState>(
            builder: (context, state) {
              return BlocProvider(
                create: (context) => CartCubit()..getCartDetails(context: context, isOverlayLoading: false),
                child: BlocConsumer<CartCubit, CartState>(
                  listener: (context, state) {
                    if (state is CartAPILoadingState) {
                      showLoadingDialog(context: context);
                    } else if (state is CartAPILoadedState) {
                      hideLoadingDialog(context: context);
                    } else if (state is CartAPIErrorState) {
                      hideLoadingDialog(context: context);
                      showToastMessage(context: context, message: state.message, isErrorMessage: true);
                    } else if (state is CartUpdatedState) {
                      hideLoadingDialog(context: context);
                      showToastMessage(context: context, message: state.message);
                    }
                  },
                  builder: (context, state) {
                    CartCubit cubit = BlocProvider.of<CartCubit>(context);
                    return state is CartLoadingState
                        ? Center(child: LoadingView())
                        : state is CartEmptyState
                            ? Center(
                                child: SemiBoldTextView(
                                    data: state.message, fontSize: 18, textColor: AppColors.redColor))
                            : state is CartErrorState
                                ? Center(
                                    child: SemiBoldTextView(
                                        data: state.message, fontSize: 18, textColor: AppColors.redColor))
                                : Column(
                                    children: [
                                      Expanded(
                                        child: SingleChildScrollView(
                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                                          child: Column(spacing: 15, children: [
                                            ...List.generate(cubit.allCartProducts.length, (int index) {
                                              return BagProductCardView(
                                                cartDetailsModel: cubit.allCartProducts[index],
                                                onUpdate: (v) async {
                                                  await cubit.getCartDetails(
                                                      context: context, isOverlayLoading: true);
                                                },
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
                                                  BoldTextView(
                                                      data: "Rs ${cubit.getTotalPrice().toStringAsFixed(2)}",
                                                      fontSize: 18,
                                                      textColor: AppColors.orangeColor),
                                                  RegularTextView(
                                                      data: "Total", textColor: AppColors.greyColor)
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
                                                  PageNavigator.pushPage(
                                                      context: context,
                                                      page: CheckoutScreen(
                                                          allCartProducts: cubit.allCartProducts));
                                                })
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                  },
                ),
              );
            },
          ))
        ],
      ),
    );
  }
}
