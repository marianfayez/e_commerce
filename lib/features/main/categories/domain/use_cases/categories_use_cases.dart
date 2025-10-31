import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/categories/domain/repositories/categories_repo.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:injectable/injectable.dart';
@injectable
class CategoriesUseCases {
  CategoriesRepo categoriesRepo;

  CategoriesUseCases(this.categoriesRepo);

  Future<Either<RouteFailures, CategoriesModel>> call(String catId) =>
      categoriesRepo.getSubCategories(catId);
}
