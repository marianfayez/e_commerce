import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';

abstract class ProductRemoteDs {

  Future<ProductModel> getProduct({String? catId});
  Future<CartModel> addToCart({String? productId});
  Future<ProductModel> searchProduct({String? query});

}