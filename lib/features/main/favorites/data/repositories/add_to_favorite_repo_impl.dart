import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/core/failuers/remote_failuers.dart';
import 'package:e_commerce_app/features/main/favorites/data/data_sources/remote/add_to_favorite_ds.dart';
import 'package:e_commerce_app/features/main/favorites/data/models/Wishlist_model.dart';
import 'package:e_commerce_app/features/main/favorites/domain/repositories/add_to_favorite_repo.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: FavoriteRepo)
class AddToFavoriteRepoImpl implements FavoriteRepo{
  AddToFavoriteDs addToFavoriteDs;
  AddToFavoriteRepoImpl(this.addToFavoriteDs);

  @override
  Future<Either<RouteFailures, WishlistModel>> addToFavorite(String? productId) async{
    try {
      var result = await addToFavoriteDs.addToFavorite(productId);
      return Right(result);
    } catch (e) {
    return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, FavoriteProductModel >> getFavoriteProduct() async{
    try {
      var result = await addToFavoriteDs.getFavoriteProduct();
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }

  @override
  Future<Either<RouteFailures, DeleteFavoriteResponse >> removeFavoriteProduct(String? productId) async{
    try {
      var result = await addToFavoriteDs.removeFavoriteProduct(productId);
      return Right(result);
    } catch (e) {
      return Left(RemoteFailures(e.toString()));
    }
  }


}