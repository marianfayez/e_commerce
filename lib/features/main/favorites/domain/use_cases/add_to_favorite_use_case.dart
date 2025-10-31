import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/favorites/data/models/Wishlist_model.dart';
import 'package:e_commerce_app/features/main/favorites/domain/repositories/add_to_favorite_repo.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToFavoriteUseCase {
  FavoriteRepo addToFavoriteRepo;
  AddToFavoriteUseCase(this.addToFavoriteRepo);

  Future<Either<RouteFailures, WishlistModel>> call(String? productId)=> addToFavoriteRepo.addToFavorite(productId);
}