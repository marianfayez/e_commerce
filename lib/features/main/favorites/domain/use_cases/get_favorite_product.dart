import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/favorites/domain/repositories/add_to_favorite_repo.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetFavoriteProductUseCase {

  FavoriteRepo favoriteRepo;
  GetFavoriteProductUseCase(this.favoriteRepo);

  Future<Either<RouteFailures, FavoriteProductModel >> call()=> favoriteRepo.getFavoriteProduct();
}