import 'package:zimozi_store/models/authentication/user_model.dart';
import 'package:zimozi_store/models/product_module/product_model.dart';

class CartDetailsModel {
  CartModel cartModel;
  ProductDataModel productDataModel;

  CartDetailsModel({required this.cartModel, required this.productDataModel});
}
