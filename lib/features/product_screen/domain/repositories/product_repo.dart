import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';

abstract class ProductRepo{

  Future<Either<RouteFailures,ProductModel>> getProduct({String? catId});
  Future<Either<RouteFailures,CartModel>> addToCart({String? productId});
  Future<Either<RouteFailures,ProductModel>> searchProduct({String? query});

}