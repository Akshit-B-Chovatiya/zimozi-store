import 'dart:convert';

class UserModel {
  bool isSuccess;
  String message;
  ZimoziUser? user;

  UserModel({required this.isSuccess, required this.message, this.user});
}

ZimoziUser zimoziUserFromJson(String str) => ZimoziUser.fromJson(json.decode(str));

String zimoziUserToJson(ZimoziUser data) => json.encode(data.toJson());

class ZimoziUser {
  final String? id;
  final String? profileImage;
  final String? emailAddress;
  final String? updatedAt;
  final String? lastName;
  final String? createdAt;
  final String? phoneNumber;
  final String? firstName;
  final List<CartModel>? cart;
  final List<String>? wishlist;

  ZimoziUser(
      {this.id,
      this.profileImage,
      this.emailAddress,
      this.updatedAt,
      this.lastName,
      this.createdAt,
      this.phoneNumber,
      this.firstName,
      this.cart,
      this.wishlist});

  ZimoziUser copyWith({
    String? id,
    String? profileImage,
    String? emailAddress,
    String? updatedAt,
    String? lastName,
    String? createdAt,
    String? phoneNumber,
    String? firstName,
    List<CartModel>? cart,
    List<String>? wishlist,
  }) =>
      ZimoziUser(
          id: id ?? this.id,
          profileImage: profileImage ?? this.profileImage,
          emailAddress: emailAddress ?? this.emailAddress,
          updatedAt: updatedAt ?? this.updatedAt,
          lastName: lastName ?? this.lastName,
          createdAt: createdAt ?? this.createdAt,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          firstName: firstName ?? this.firstName,
          cart: cart ?? this.cart,
          wishlist: wishlist ?? this.wishlist);

  factory ZimoziUser.fromJson(Map<String, dynamic> json) => ZimoziUser(
        id: json["id"],
        profileImage: json["profile_image"],
        emailAddress: json["email_address"],
        updatedAt: json["updated_at"].toString(),
        lastName: json["last_name"],
        createdAt: json["created_at"].toString(),
        phoneNumber: json["phone_number"],
        firstName: json["first_name"],
        wishlist: json["wishlist"] == null ? [] : List<String>.from(json["wishlist"]!.map((x) => x)),
        cart:
            json["cart"] == null ? [] : List<CartModel>.from(json["cart"]!.map((x) => CartModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "profile_image": profileImage,
        "email_address": emailAddress,
        "updated_at": updatedAt,
        "last_name": lastName,
        "created_at": createdAt,
        "phone_number": phoneNumber,
        "first_name": firstName,
        "wishlist": wishlist == null ? [] : List<dynamic>.from(wishlist!.map((x) => x)),
        "cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x.toJson())),
      };
}

class CartModel {
  final String? id;
  final int? quantity;

  CartModel({
    this.id,
    this.quantity,
  });

  CartModel copyWith({
    String? id,
    int? quantity,
  }) =>
      CartModel(
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
      );

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
      };
}
