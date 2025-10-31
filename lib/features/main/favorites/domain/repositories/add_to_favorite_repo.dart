import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/favorites/data/models/Wishlist_model.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';

abstract class FavoriteRepo{

  Future<Either<RouteFailures,WishlistModel>> addToFavorite(String? productId);
  Future<Either<RouteFailures,FavoriteProductModel >> getFavoriteProduct();
  Future<Either<RouteFailures,DeleteFavoriteResponse  >> removeFavoriteProduct(String? productId);

}