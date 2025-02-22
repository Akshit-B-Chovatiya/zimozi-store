import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zimozi_store/config/app_constant.dart';
import 'package:zimozi_store/models/authentication/authentication_model.dart';
import 'package:zimozi_store/models/orders/my_orders_model.dart';
import 'package:zimozi_store/utils/common/log_services.dart';
import 'package:zimozi_store/utils/dialog_services/loading_view.dart';
import 'package:zimozi_store/utils/firebase_services/firebase_service.dart';
import 'package:zimozi_store/utils/storage_services/shared_preferences.dart';

class FirebaseOrderService {
  static Future<AuthenticationModel> createOrder(
      {required BuildContext context,
      required List<Map<String, dynamic>> items,
      required Map<String, dynamic> paymentDetails,
      required double totalAmount}) async {
    showLoadingDialog(context: context);
    String? userId = await LocalStorage.getString(key: AppConstants.userId);
    if (userId == null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;
      }
    }
    CollectionReference ordersRef = FirebaseFirestore.instance.collection(FirebaseKeys.orders);
    String orderId = ordersRef.doc().id;
    Map<String, dynamic> orderData = {
      "order_id": orderId,
      "user_id": userId,
      "items": items,
      "payment_details": paymentDetails,
      "total_amount": totalAmount,
      "status": "Pending",
      "created_at": DateTime.now()
    };
    showLogs(message: "DATA : $orderData");
    try {
      await ordersRef.doc(orderId).set(orderData);
      await FirebaseFirestore.instance.collection(FirebaseKeys.users).doc(userId).update({"cart": []});
      return AuthenticationModel(isSuccess: true, message: "Order placed successfully!", user: null);
    } on FirebaseAuthException catch (e) {
      return AuthenticationModel(
          isSuccess: false,
          message:
              FirebaseService.getErrorSpecificMessage(code: e.code) ?? e.message ?? "Order creation failed!",
          user: null);
    } catch (e) {
      return AuthenticationModel(
          isSuccess: true, message: "Something went wrong to place order : $e", user: null);
    }
  }

  static Future<List<MyOrdersModel>> getAllOrders() async {
    String? userId = await LocalStorage.getString(key: AppConstants.userId);
    if (userId == null) {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userId = user.uid;
      }
    }
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(FirebaseKeys.orders)
        .where("user_id", isEqualTo: userId)
        .get();

    List<Map<String, dynamic>> orders = querySnapshot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
    showLogs(message: "ORDERS : $orders");
    return orders.map((e) => MyOrdersModel.fromJson(e)).toList();
  }
}
