import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';

abstract class CategoriesRepo{

  Future<Either<RouteFailures,CategoriesModel>>getSubCategories(String catId);
}