import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:e_commerce_app/features/main/home/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeUseCases {

  HomeRepo homeRepo;
  HomeUseCases(this.homeRepo);

  Future<Either<RouteFailures,CategoriesModel>> call()=>
      homeRepo.getCategories();
}