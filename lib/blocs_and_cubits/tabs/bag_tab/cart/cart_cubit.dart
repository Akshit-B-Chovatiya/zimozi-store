import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/account/account_cubit.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/models/checkout_process/cart_details_model.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/utils/common/log_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_product_service.dart';
import 'package:zimozi_store/utils/storage_services/shared_preferences.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialState());

  List<CartDetailsModel> allCartProducts = [];

  Future<void> getCartDetails({required BuildContext context, required bool isOverlayLoading}) async {
    if (isOverlayLoading) {
      emit(CartAPILoadingState());
    } else {
      emit(CartLoadingState());
    }
    AccountCubit accountCubit = BlocProvider.of<AccountCubit>(context);
    await LocalStorage.removeKey(key: AppConstants.userDetails);
    await accountCubit.getUserDetails();
    List<CartModel> cartList = accountCubit.zimoziUser?.cart ?? [];
    showLogs(message: "CART : ${cartList.map((e) => "${e.id} : ${e.quantity}").toList()}");
    ProductModel productModel = await FirebaseProductService.getCartProducts(
        context: AppConstants.navigatorKey.currentContext ?? context);
    if (productModel.isSuccess) {
      if (productModel.allProducts.isEmpty) {
        allCartProducts.clear();
        if (isOverlayLoading) {
          hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
        }
        emit(CartEmptyState(message: productModel.message));
      } else {
        allCartProducts.clear();
        allCartProducts.addAll(productModel.allProducts
            .map((e) => CartDetailsModel(
                cartModel: cartList.firstWhere((element) => (element.id ?? "") == (e.id ?? "")),
                productDataModel: e))
            .toList());
        if (isOverlayLoading) {
          emit(CartAPILoadedState());
        } else {
          emit(CartLoadedState());
        }
      }
    } else {
      if (isOverlayLoading) {
        emit(CartAPIErrorState(message: productModel.message));
      } else {
        emit(CartErrorState(message: productModel.message));
      }
    }
  }

  double getTotalPrice() {
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
}
