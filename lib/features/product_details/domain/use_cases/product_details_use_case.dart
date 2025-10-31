import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/product_details/data/model/product_details_model.dart';
import 'package:e_commerce_app/features/product_details/domain/repositories/product_details_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductDetailsUseCase {

  ProductDetailsRepo productDetailsRepo;
  ProductDetailsUseCase(this.productDetailsRepo);

  Future<Either<RouteFailures, ProductDetailsModel>> call(String productId)=>productDetailsRepo.getProductDetails(productId);
}