import 'dart:convert';

import 'package:zimozi_store/utils/storage_services/validation.dart';

List<MyOrdersModel> myOrdersModelFromJson(String str) =>
    List<MyOrdersModel>.from(json.decode(str).map((x) => MyOrdersModel.fromJson(x)));

String myOrdersModelToJson(List<MyOrdersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyOrdersModel {
  final PaymentDetails? paymentDetails;
  final double? totalAmount;
  final String? userId;
  final String? createdAt;
  final List<Item>? items;
  final String? orderId;
  final String? status;

  MyOrdersModel({
    this.paymentDetails,
    this.totalAmount,
    this.userId,
    this.createdAt,
    this.items,
    this.orderId,
    this.status,
  });

  MyOrdersModel copyWith({
    PaymentDetails? paymentDetails,
    double? totalAmount,
    String? userId,
    String? createdAt,
    List<Item>? items,
    String? orderId,
    String? status,
  }) =>
      MyOrdersModel(
        paymentDetails: paymentDetails ?? this.paymentDetails,
        totalAmount: totalAmount ?? this.totalAmount,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        items: items ?? this.items,
        orderId: orderId ?? this.orderId,
        status: status ?? this.status,
      );

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
        paymentDetails:
            json["payment_details"] == null ? null : PaymentDetails.fromJson(json["payment_details"]),
        totalAmount: json["total_amount"]?.toDouble(),
        userId: json["user_id"],
        createdAt: formatTimestamp(timestamp:json["created_at"]),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        orderId: json["order_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "payment_details": paymentDetails?.toJson(),
        "total_amount": totalAmount,
        "user_id": userId,
        "created_at": createdAt,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "order_id": orderId,
        "status": status,
      };
}

class Item {
  final int? quantity;
  final double? price;
  final String? imageUrl;
  final String? name;
  final String? id;
  final double? discountedPrice;

  Item({
    this.quantity,
    this.price,
    this.imageUrl,
    this.name,
    this.id,
    this.discountedPrice,
  });

  Item copyWith({
    int? quantity,
    double? price,
    String? imageUrl,
    String? name,
    String? id,
    double? discountedPrice,
  }) =>
      Item(
        quantity: quantity ?? this.quantity,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        name: name ?? this.name,
        id: id ?? this.id,
        discountedPrice: discountedPrice ?? this.discountedPrice,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        quantity: json["quantity"],
        price: json["price"],
        imageUrl: json["image_url"],
        name: json["name"],
        id: json["id"],
        discountedPrice: json["discounted_price"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "price": price,
        "image_url": imageUrl,
        "name": name,
        "id": id,
        "discounted_price": discountedPrice,
      };
}

class PaymentDetails {
  final String? id;

  PaymentDetails({
    this.id,
  });

  PaymentDetails copyWith({
    String? id,
  }) =>
      PaymentDetails(
        id: id ?? this.id,
      );

  factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
