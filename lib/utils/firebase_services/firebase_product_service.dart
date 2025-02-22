import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zimozi_store/blocs_and_cubits/tabs/account_tab/account/account_cubit.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';
import 'package:zimozi_store/utils/common/log_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_service.dart';
import 'package:zimozi_store/utils/storage_services/shared_preferences.dart';

class FirebaseProductService {
  static Future<ProductModel> getAllProducts() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(FirebaseKeys.products).get();
      List<ProductDataModel> productList = querySnapshot.docs
          .map((doc) => ProductDataModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      if (productList.isEmpty) {
        return ProductModel(isSuccess: true, allProducts: productList, message: "No products found!");
      } else {
        return ProductModel(
            isSuccess: true, allProducts: productList, message: "All product are fetched successfully!");
      }
    } catch (e) {
      showLogs(message: "ERROR : $e");
      return ProductModel(isSuccess: false, allProducts: [], message: "Error to fetch products!");
    }
  }

  static Future<ProductModel> getWishlistProducts({required BuildContext context}) async {
    try {
      AccountCubit accountCubit = BlocProvider.of<AccountCubit>(context);
      List<String> wishList = accountCubit.zimoziUser?.wishlist ?? [];
      if (wishList.isEmpty) {
        return ProductModel(isSuccess: true, allProducts: [], message: "Wishlist is empty!");
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(FirebaseKeys.products)
            .where(FieldPath.documentId, whereIn: wishList)
            .get();
        List<ProductDataModel> productList = querySnapshot.docs
            .map((doc) => ProductDataModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        if (productList.isEmpty) {
          return ProductModel(isSuccess: true, allProducts: productList, message: "Wishlist is empty!");
        } else {
          return ProductModel(
              isSuccess: true, allProducts: productList, message: "Wishlist are fetched successfully!");
        }
      }
    } catch (e) {
      showLogs(message: "ERROR : $e");
      return ProductModel(isSuccess: false, allProducts: [], message: "Error to fetch wishlist!");
    }
  }

  static Future<ProductModel> updateWishlistProducts(
      {required BuildContext context, required String productId}) async {
    showLoadingDialog(context: context);
    String? userId = await LocalStorage.getString(key: AppConstants.userId);
    if (userId == null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;
      }
    }
    if (userId != null) {
      try {
        ZimoziUser? zimoziUser =
            BlocProvider.of<AccountCubit>(AppConstants.navigatorKey.currentContext ?? context).zimoziUser;
        List<String> wishList = [];
        if (zimoziUser != null) {
          wishList.clear();
          wishList.addAll(zimoziUser.wishlist ?? []);
          if (wishList.contains(productId)) {
            wishList.remove(productId);
          } else {
            wishList.add(productId);
          }
        } else {
          hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
          return ProductModel(isSuccess: false, message: "Something went wrong!", allProducts: []);
        }
        await FirebaseFirestore.instance
            .collection(FirebaseKeys.users)
            .doc(userId)
            .update({"wishlist": wishList});
        await LocalStorage.removeKey(key: AppConstants.userDetails);
        await BlocProvider.of<AccountCubit>(AppConstants.navigatorKey.currentContext ?? context)
            .getUserDetails();
        hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
        return ProductModel(isSuccess: true, message: "Wishlist updated!", allProducts: []);
      } on FirebaseAuthException catch (e) {
        hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
        return ProductModel(
            isSuccess: false,
            message: FirebaseService.getErrorSpecificMessage(code: e.code) ??
                e.message ??
                "Wishlist details update error!",
            allProducts: []);
      } catch (e) {
        hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
        return ProductModel(isSuccess: false, message: "Wishlist details update error!", allProducts: []);
      }
    } else {
      hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
      return ProductModel(isSuccess: false, message: "Something went wrong!", allProducts: []);
    }
  }

  static Future<ProductModel> getCartProducts({required BuildContext context}) async {
    try {
      AccountCubit accountCubit = BlocProvider.of<AccountCubit>(context);
      List<CartModel> cartList = accountCubit.zimoziUser?.cart ?? [];
      if (cartList.isEmpty) {
        return ProductModel(isSuccess: true, allProducts: [], message: "Cart is empty!");
      } else {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(FirebaseKeys.products)
            .where(FieldPath.documentId, whereIn: cartList.map((e) => e.id ?? "").toList())
            .get();
        List<ProductDataModel> productList = querySnapshot.docs
            .map((doc) => ProductDataModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
        if (productList.isEmpty) {
          return ProductModel(isSuccess: true, allProducts: productList, message: "Cart is empty!");
        } else {
          return ProductModel(
              isSuccess: true, allProducts: productList, message: "Cart details are fetched successfully!");
        }
      }
    } catch (e) {
      showLogs(message: "ERROR : $e");
      return ProductModel(isSuccess: false, allProducts: [], message: "Error to fetch cart details!");
    }
  }

  static Future<ProductModel> addOrRemoveProductToCartBag(
      {required BuildContext context, required String productId, int qty = 1}) async {
    showLoadingDialog(context: context);
    String? userId = await LocalStorage.getString(key: AppConstants.userId);
    if (userId == null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;
      }
    }
    if (userId != null) {
      try {
        await LocalStorage.removeKey(key: AppConstants.userDetails);
        await BlocProvider.of<AccountCubit>(AppConstants.navigatorKey.currentContext ?? context)
            .getUserDetails();
        ZimoziUser? zimoziUser =
            BlocProvider.of<AccountCubit>(AppConstants.navigatorKey.currentContext ?? context).zimoziUser;
        List<CartModel> cartList = [];
        if (zimoziUser != null) {
          cartList.clear();
          cartList.addAll(zimoziUser.cart ?? []);
          if (cartList.map((e) => e.id ?? "").toList().contains(productId)) {
            if (qty == 0 || qty == -1) {
              cartList.removeWhere((element) => (element.id ?? "") == productId);
            } else {
              int index = cartList.indexWhere((element) => (element.id ?? "") == productId);
              CartModel tempData = cartList[index];
              tempData = CartModel(quantity: qty, id: cartList[index].id);
              cartList[index] = tempData;
            }
          } else {
            cartList.add(CartModel(id: productId, quantity: 1));
          }
        } else {
          hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
          return ProductModel(isSuccess: false, message: "Something went wrong!", allProducts: []);
        }
        await FirebaseFirestore.instance
            .collection(FirebaseKeys.users)
            .doc(userId)
            .update({"cart": cartList.map((e) => e.toJson()).toList()});
        await LocalStorage.removeKey(key: AppConstants.userDetails);
        await BlocProvider.of<AccountCubit>(AppConstants.navigatorKey.currentContext ?? context)
            .getUserDetails();
        hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
        return ProductModel(isSuccess: true, message: "Bag details updated!", allProducts: []);
      } on FirebaseAuthException catch (e) {
        hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
        return ProductModel(
            isSuccess: false,
            message: FirebaseService.getErrorSpecificMessage(code: e.code) ??
                e.message ??
                "Bag details update error!",
            allProducts: []);
      } catch (e) {
        hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
        return ProductModel(isSuccess: false, message: "Bag details update error!", allProducts: []);
      }
    } else {
      hideLoadingDialog(context: AppConstants.navigatorKey.currentContext ?? context);
      return ProductModel(isSuccess: false, message: "Something went wrong!", allProducts: []);
    }
  }
}
