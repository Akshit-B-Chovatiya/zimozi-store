class ProductModel {
  final bool isSuccess;
  final String message;
  final List<ProductDataModel> allProducts;

  ProductModel({required this.isSuccess, required this.message, required this.allProducts});
}

class ProductDataModel {
  final String? id;
  final double? price;
  final String? name;
  final String? imageUrl;
  final double? discountedPrice;

  ProductDataModel({
    this.id,
    this.price,
    this.name,
    this.imageUrl,
    this.discountedPrice,
  });

  ProductDataModel copyWith({
    String? id,
    double? price,
    String? name,
    String? imageUrl,
    double? discountedPrice,
  }) =>
      ProductDataModel(
        id: id ?? this.id,
        price: price ?? this.price,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        discountedPrice: discountedPrice ?? this.discountedPrice,
      );

  factory ProductDataModel.fromJson(Map<String, dynamic> json) => ProductDataModel(
        id: json["id"],
        price: json["price"]?.toDouble(),
        name: json["name"],
        imageUrl: json["image_url"],
        discountedPrice: json["discounted_price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "name": name,
        "image_url": imageUrl,
        "discounted_price": discountedPrice,
      };
}
