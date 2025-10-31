part of 'add_to_favorite_bloc.dart';

class AddToFavoriteEvent {}

class FavoriteProductEvent extends AddToFavoriteEvent {
  String? productId;

  FavoriteProductEvent({required this.productId});
}

class GetFavoriteProductEvent extends AddToFavoriteEvent {}

class RemoveFavoriteProductEvent extends AddToFavoriteEvent {
  String? productId;

  RemoveFavoriteProductEvent({required this.productId});
}
