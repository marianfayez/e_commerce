import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/cart/domain/repositories/get_cart_repo.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveCartUseCase {

  GetCartRepo getCartRepo;

  RemoveCartUseCase(this.getCartRepo);

  Future<Either<RouteFailures, CartModel>> call(String productId ) => getCartRepo.removeCartItem(productId);
}