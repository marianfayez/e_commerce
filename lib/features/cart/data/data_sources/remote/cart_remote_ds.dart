import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';

abstract class CartRemoteDs{

  Future<CartModel> getCart();
  Future<CartModel> updateCartItems(String? productId,int? newQuantity);
  Future<CartModel> removeCartItem(String? productId);

}