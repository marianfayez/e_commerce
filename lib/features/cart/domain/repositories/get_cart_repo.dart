import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';

abstract class GetCartRepo{

  Future<Either<RouteFailures,CartModel>> getCart();
  Future<Either<RouteFailures,CartModel>> updateCartItem(String? productId,int? newQuantity);
  Future<Either<RouteFailures,CartModel>> removeCartItem(String? productId);

}