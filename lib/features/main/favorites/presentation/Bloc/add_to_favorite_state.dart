part of 'add_to_favorite_bloc.dart';

enum AddToFavoriteRequestState { initial, loading, success, error }
enum GetFavoriteRequestState { initial, loading, success, error }
enum RemoveFavoriteRequestState { initial, loading, success, error }

class AddToFavoriteState {
  AddToFavoriteRequestState? addToFavoriteRequestState;
  WishlistModel? wishlistModel;
  RouteFailures? addToFavoriteFailures;
  GetFavoriteRequestState? getFavoriteRequestState;
  FavoriteProductModel ? favoriteProductModel;
  RouteFailures? getFavoriteFailures;
  RemoveFavoriteRequestState? removeFavoriteRequestState;
  RouteFailures? removeFavoriteFailures;
  DeleteFavoriteResponse? deleteFavoriteResponse;
  AddToFavoriteState({
    this.addToFavoriteRequestState,
    this.wishlistModel,
    this.addToFavoriteFailures,
    this.removeFavoriteRequestState,
    this.favoriteProductModel,
    this.getFavoriteFailures,
    this.getFavoriteRequestState,
    this.removeFavoriteFailures,
    this.deleteFavoriteResponse
  });

  AddToFavoriteState copyWith({
    DeleteFavoriteResponse? deleteFavoriteResponse,
    AddToFavoriteRequestState? addToFavoriteRequestState,
    WishlistModel? wishlistModel,
    RouteFailures? addToFavoriteFailures,
    RemoveFavoriteRequestState? removeFavoriteRequestState,
    FavoriteProductModel ? favoriteProductModel,
    RouteFailures? getFavoriteFailures,
    GetFavoriteRequestState? getFavoriteRequestState,
    RouteFailures? removeFavoriteFailures
  }) {
    return AddToFavoriteState(
      deleteFavoriteResponse: deleteFavoriteResponse??this.deleteFavoriteResponse,
      addToFavoriteRequestState:
          addToFavoriteRequestState ?? this.addToFavoriteRequestState,
      wishlistModel: wishlistModel ?? this.wishlistModel,
      addToFavoriteFailures:
          addToFavoriteFailures ?? this.addToFavoriteFailures,
      getFavoriteRequestState:
      getFavoriteRequestState ?? this.getFavoriteRequestState,
      favoriteProductModel: favoriteProductModel ?? this.favoriteProductModel,
      getFavoriteFailures:
      getFavoriteFailures ?? this.getFavoriteFailures,
      removeFavoriteRequestState:
      removeFavoriteRequestState ?? this.removeFavoriteRequestState,
      removeFavoriteFailures:
      getFavoriteFailures ?? this.getFavoriteFailures,
    );
  }
}

final class AddToFavoriteInitial extends AddToFavoriteState {
  AddToFavoriteInitial()
      : super(addToFavoriteRequestState: AddToFavoriteRequestState.initial);
}
