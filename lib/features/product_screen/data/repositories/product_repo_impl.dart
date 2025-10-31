import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/features/product_screen/data/data_sources/remote/product_remote_ds.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:e_commerce_app/features/product_screen/domain/repositories/product_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductRepo)
class ProductRepoImpl implements ProductRepo {
  ProductRemoteDs productRemoteDs;

  ProductRepoImpl(this.productRemoteDs);

  @override
  Future<Either<RouteFailures, ProductModel>> getProduct({String? catId}) async {
    try {
      var result = await productRemoteDs.getProduct(catId: catId);
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, CartModel>> addToCart({String? productId}) async{
    try {
      var result = await productRemoteDs.addToCart(productId: productId);
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, ProductModel>> searchProduct({String? query}) async{
    try {
      var result = await productRemoteDs.searchProduct(query: query);
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }
}
