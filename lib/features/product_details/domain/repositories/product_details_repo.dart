import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/product_details/data/model/product_details_model.dart';

abstract class ProductDetailsRepo {

  Future<Either<RouteFailures,ProductDetailsModel>> getProductDetails(String productId);

}