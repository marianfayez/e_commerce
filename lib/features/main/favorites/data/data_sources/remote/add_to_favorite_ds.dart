import 'package:e_commerce_app/features/main/favorites/data/models/Wishlist_model.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';

abstract class AddToFavoriteDs{

  Future<WishlistModel> addToFavorite(String? productId);
  Future<FavoriteProductModel > getFavoriteProduct();
  Future<DeleteFavoriteResponse  > removeFavoriteProduct(String? productId);

}