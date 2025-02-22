import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_product_service.dart';

part 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  DiscoverCubit() : super(DiscoverInitialState());

  List<ProductDataModel> allProducts = [];
  List<ProductDataModel> wishList = [];

  Future<void> fetchAllProducts() async {
    emit(DiscoverLoadingState());
    ProductModel productModel = await FirebaseProductService.getAllProducts();
    if (productModel.isSuccess) {
      if (productModel.allProducts.isEmpty) {
        emit(DiscoverEmptyState(message: productModel.message));
      } else {
        allProducts.clear();
        allProducts.addAll(productModel.allProducts);
        emit(DiscoverLoadedState());
      }
    } else {
      emit(DiscoverErrorState(message: productModel.message));
    }
  }

  Future<void> fetchAllWishlistProducts({required BuildContext context}) async {
    emit(DiscoverLoadingState());
    ProductModel productModel = await FirebaseProductService.getWishlistProducts(context: context);
    if (productModel.isSuccess) {
      if (productModel.allProducts.isEmpty) {
        emit(DiscoverEmptyState(message: productModel.message));
      } else {
        wishList.clear();
        wishList.addAll(productModel.allProducts);
        emit(DiscoverLoadedState());
      }
    } else {
      emit(DiscoverErrorState(message: productModel.message));
    }
  }

  Future<void> fetchAllCartProducts({required BuildContext context}) async {
    emit(DiscoverLoadingState());
    ProductModel productModel = await FirebaseProductService.getWishlistProducts(context: context);
    if (productModel.isSuccess) {
      if (productModel.allProducts.isEmpty) {
        emit(DiscoverEmptyState(message: productModel.message));
      } else {
        wishList.clear();
        wishList.addAll(productModel.allProducts);
        emit(DiscoverLoadedState());
      }
    } else {
      emit(DiscoverErrorState(message: productModel.message));
    }
  }
}
