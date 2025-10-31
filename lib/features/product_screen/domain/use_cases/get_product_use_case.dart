import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:e_commerce_app/features/product_screen/domain/repositories/product_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductUseCase{

  ProductRepo productRepo;
  GetProductUseCase(this.productRepo);

  Future<Either<RouteFailures, ProductModel>>  call({String? catId})=>productRepo.getProduct(catId:catId);
}