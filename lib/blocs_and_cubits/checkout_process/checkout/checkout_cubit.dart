import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/account/account_cubit.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/authentication/authentication_model.dart';
import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/models/checkout_process/address_model.dart';
import 'package:zimozi_store/models/checkout_process/cart_details_model.dart';
import 'package:zimozi_store/models/payment_services/payment_request_model.dart';
import 'package:zimozi_store/screens/checkout_process/order_confirmation_screen.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_orders_service.dart';
import 'package:zimozi_store/utils/payment_service/payments_integration.dart';
import 'package:zimozi_store/utils/views/page_navigator.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitialState());

  AddressModel? addressDetails;

  void updateAddressDetails({required AddressModel address}) {
    emit(CheckoutInitialState());
    addressDetails = address;
    emit(CheckoutUpdatedState());
  }

  Future<void> validateAndMakePayment(
      {required BuildContext context, required List<CartDetailsModel> allCartProducts}) async {
    emit(CheckoutLoadingState());
    if (addressDetails == null) {
      emit(CheckoutErrorState(message: "Please add delivery address!"));
    } else {
      emit(CheckoutUpdatedState());
      ZimoziUser? zimoziUser = BlocProvider.of<AccountCubit>(context).zimoziUser;
      PaymentsIntegration.stripePayment(
          context: context,
          paymentRequestModel: PaymentRequestModel(
              amount: totalBillableAmount(allCartProducts: allCartProducts),
              currencyCode: "INR",
              label: "Order",
              countryCode: "IN",
              merchantDisplayName: "Zimozi Store",
              note: "Fresh order",
              paymentDescription: "Pay via card",
              customerName: "${zimoziUser?.firstName ?? ""} ${zimoziUser?.lastName ?? ""}",
              address: "${addressDetails?.houseNumber} ${addressDetails?.street}",
              cityName: addressDetails?.city ?? "",
              stateCode: addressDetails?.state ?? "",
              postalCode: addressDetails?.pinCode ?? "",
              customerEmail: zimoziUser?.emailAddress ?? "",
              customerPhone: zimoziUser?.phoneNumber ?? "",
              onError: (bool v, String t) {
                emit(CheckoutErrorState(message: t));
              },
              onSuccess: (bool v, String t, Map<String, dynamic> pd) async {
                emit(CheckoutLoadedState(message: t));
                AuthenticationModel authenticationModel = await FirebaseOrderService.createOrder(
                    context: context,
                    items: allCartProducts.map((e) {
                      Map<String, dynamic> data = e.productDataModel.toJson();
                      data.addAll({"quantity": e.cartModel.quantity});
                      return data;
                    }).toList(),
                    paymentDetails: pd,
                    totalAmount: totalBillableAmount(allCartProducts: allCartProducts));
                if (authenticationModel.isSuccess) {
                  PageNavigator.pushAndRemoveUntilPage(
                      context: AppConstants.navigatorKey.currentContext ?? context,
                      page: OrderConfirmationScreen(
                          isSuccessOrder: true,
                          address: addressDetails!,
                          items: allCartProducts,
                          paymentDetails: pd));
                }
              },
              onCancelled: (bool v, String t) {
                emit(CheckoutErrorState(message: t));
              }));
    }
  }

  double getTotalPrice({required List<CartDetailsModel> allCartProducts}) {
    if (allCartProducts.isEmpty) {
      return 0;
    } else {
      return allCartProducts
          .map((CartDetailsModel e) => double.parse(
              ((e.cartModel.quantity ?? 0) * (e.productDataModel.discountedPrice ?? 0)).toString()))
          .toList()
          .reduce((value, element) => value + element);
    }
  }

  double getTaxAmount({required List<CartDetailsModel> allCartProducts}) {
    double itemPrice = getTotalPrice(allCartProducts: allCartProducts);
    return (itemPrice * 0.18);
  }

  double getDiscountAmount({required List<CartDetailsModel> allCartProducts}) {
    double itemPrice = getTotalPrice(allCartProducts: allCartProducts);
    double taxPrice = getTaxAmount(allCartProducts: allCartProducts);
    return (itemPrice + taxPrice) / 10;
  }

  double totalBillableAmount({required List<CartDetailsModel> allCartProducts}) {
    double itemPrice = getTotalPrice(allCartProducts: allCartProducts);
    double taxPrice = getTaxAmount(allCartProducts: allCartProducts);
    double discountPrice = getDiscountAmount(allCartProducts: allCartProducts);

    return (itemPrice + taxPrice) - discountPrice;
  }
}
