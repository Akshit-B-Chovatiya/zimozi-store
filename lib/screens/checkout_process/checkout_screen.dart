import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/checkout_process/checkout/checkout_cubit.dart';
import 'package:zimozi_store/config/app_colors.dart';
import 'package:zimozi_store/config/app_images.dart';
import 'package:zimozi_store/models/checkout_process/address_model.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/screens/checkout_process/address_details_screen.dart';
import 'package:zimozi_store/utils/common/toast_message_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/storage_services/validation.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';
import 'package:zimozi_store/widgets/checkout_process/bill_summary_card_view.dart';
import 'package:zimozi_store/widgets/common/appbar_view.dart';
import 'package:zimozi_store/widgets/common/button_view.dart';
import 'package:zimozi_store/widgets/common/divider_view.dart';
import 'package:zimozi_store/widgets/common/text_widgets.dart';
import 'package:zimozi_store/widgets/product_views/checkout_product_card_view.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarView(
              title: "Checkout",
              prefixIcon: AppImages.backArrowIcon,
              onPrefixPressed: () {
                PageNavigator.pop(context: context);
              }),
          Expanded(
              child: BlocProvider(
            create: (context) => CheckoutCubit(),
            child: BlocConsumer<CheckoutCubit, CheckoutState>(
              listener: (context, state) {
                if (state is CheckoutLoadingState) {
                  showLoadingDialog(context: context);
                } else if (state is CheckoutLoadedState) {
                  hideLoadingDialog(context: context);
                  showToastMessage(context: context, message: state.message);
                } else if (state is CheckoutErrorState) {
                  hideLoadingDialog(context: context);
                  showToastMessage(context: context, message: state.message, isErrorMessage: true);
                }
              },
              builder: (context, state) {
                CheckoutCubit cubit = BlocProvider.of<CheckoutCubit>(context);
                return Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                            child:
                                Column(crossAxisAlignment: CrossAxisAlignment.start, spacing: 15, children: [
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (BuildContext context, int index) {
                                    return CheckoutProductCardView(
                                        productModel: ProductModel(
                                            title:
                                                "Product title in two line to check align and overflow of size",
                                            imageLink:
                                                "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                                            isFavourite: true,
                                            newPrice: 299,
                                            oldPrice: 350));
                                  },
                                  separatorBuilder: (BuildContext context, int index) {
                                    return DividerView(topMargin: 10, bottomMargin: 10);
                                  },
                                  itemCount: 3),
                              SizedBox(height: 20),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(child: SemiBoldTextView(data: "Delivery Address", fontSize: 18)),
                                  ButtonView(
                                      title: cubit.addressDetails == null ? "Add Address" : "Edit Address",
                                      width: MediaQuery.of(context).size.width / 4,
                                      topPadding: 3,
                                      bottomPadding: 3,
                                      bottomMargin: 0,
                                      topMargin: 0,
                                      textSize: 12,
                                      onTap: () {
                                        PageNavigator.pushPage(
                                            context: context,
                                            page: AddressDetailsScreen(
                                                address: cubit.addressDetails,
                                                isForEdit: cubit.addressDetails != null,
                                                onSave: (AddressModel address) {
                                                  cubit.updateAddressDetails(address: address);
                                                }));
                                      })
                                ],
                              ),
                              cubit.addressDetails != null
                                  ? MediumTextView(data: getFormattedAddress(address: cubit.addressDetails!))
                                  : Container(),
                              SemiBoldTextView(data: "Bill Summary", fontSize: 18, topPadding: 20),
                              BillSummaryCardView(title: "Item total", value: "Rs. 500.00"),
                              BillSummaryCardView(title: "TAX (10%)", value: "Rs. 50.00"),
                              BillSummaryCardView(title: "Delivery Charge", value: "free"),
                              BillSummaryCardView(title: "Discounts", value: "Rs. 0.00"),
                              BillSummaryCardView(title: "Grand Total", value: "Rs. 580.00"),
                            ]))),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          border: Border(top: BorderSide(color: AppColors.liteGreyColor)),
                          color: AppColors.yellowColor.withValues(alpha: (0.1))),
                      child: SafeArea(
                        top: false,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldTextView(
                                      data: "Rs. 500.00", fontSize: 18, textColor: AppColors.orangeColor),
                                  RegularTextView(
                                      data: "Total Payable Amount", textColor: AppColors.greyColor)
                                ],
                              ),
                            ),
                            ButtonView(
                                title: "Place Order",
                                width: MediaQuery.of(context).size.width / 3,
                                topPadding: 6,
                                bottomPadding: 6,
                                bottomMargin: 0,
                                textSize: 13,
                                topMargin: 0,
                                onTap: () async {
                                  await cubit.validateAndMakePayment(context: context);
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ))
        ],
      ),
    );
  }
}
