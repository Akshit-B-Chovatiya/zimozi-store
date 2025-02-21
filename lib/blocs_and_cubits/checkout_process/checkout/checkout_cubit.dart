import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zimozi_store/models/checkout_process/address_model.dart';
import 'package:zimozi_store/screens/checkout_process/order_confirmation_screen.dart';
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

  Future<void> validateAndMakePayment({required BuildContext context}) async {
    emit(CheckoutLoadingState());
    if (addressDetails == null) {
      emit(CheckoutErrorState(message: "Please add delivery address!"));
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        if (context.mounted) {
          PageNavigator.pushAndRemoveUntilPage(
              context: context,
              page: OrderConfirmationScreen(isSuccessOrder: true, address: addressDetails!));
        }
      });
    }
  }
}
