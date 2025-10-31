import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/features/product_details/data/data_sources/remote/product_details_ds.dart';
import 'package:e_commerce_app/features/product_details/data/model/product_details_model.dart';
import 'package:e_commerce_app/features/product_details/domain/repositories/product_details_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRepo)
class ProductDetailsRepoImpl implements ProductDetailsRepo{

  ProductDetailsDs productDetailsDs;
  ProductDetailsRepoImpl(this.productDetailsDs);

  @override
  Future<Either<RouteFailures, ProductDetailsModel>> getProductDetails(String productId) async{
    try {
      var result = await productDetailsDs.getProductDetails(productId);
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

}