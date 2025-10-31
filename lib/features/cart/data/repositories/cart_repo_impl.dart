import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/features/cart/data/data_sources/remote/cart_remote_ds.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/get_cart_repo.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: GetCartRepo)
class CartRepoImpl implements GetCartRepo {
  CartRemoteDs cartRemoteDs;

  CartRepoImpl(this.cartRemoteDs);

  @override
  Future<Either<RouteFailures, CartModel>> getCart() async {
    try {
      var result = await cartRemoteDs.getCart();
      return Right(result);
    } catch (e) {
      print("Parsing error: $e");
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, CartModel>> removeCartItem(String? productId) async{
    try {
      var result = await cartRemoteDs.removeCartItem(productId);
      return Right(result);
    } catch (e) {
      print("Parsing error: $e");
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, CartModel>> updateCartItem(String? productId, int? newQuantity) async{
    try {
      var result = await cartRemoteDs.updateCartItems(productId,newQuantity);
      return Right(result);
    } catch (e) {
      print("Parsing error: $e");
      return Left(RemoteFailures(e.toString()));
    }
  }
}
