import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:e_commerce_app/features/product_screen/domain/repositories/product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToCartUseCase{

  ProductRepo productRepo;
  AddToCartUseCase(this.productRepo);

  Future<Either<RouteFailures, CartModel>> call({String? productId})=>productRepo.addToCart(productId:productId);
}