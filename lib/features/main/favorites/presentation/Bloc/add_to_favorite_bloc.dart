import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/favorites/data/models/Wishlist_model.dart';
import 'package:e_commerce_app/features/main/favorites/domain/use_cases/add_to_favorite_use_case.dart';
import 'package:e_commerce_app/features/main/favorites/domain/use_cases/get_favorite_product.dart';
import 'package:e_commerce_app/features/main/favorites/domain/use_cases/remove_from_favorite.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'add_to_favorite_event.dart';

part 'add_to_favorite_state.dart';

@injectable
class AddToFavoriteBloc extends Bloc<AddToFavoriteEvent, AddToFavoriteState> {
  AddToFavoriteUseCase addToFavoriteUseCase;
  GetFavoriteProductUseCase getFavoriteProductUseCase;
  RemoveFromFavorite removeFavoriteProductUseCase;

  AddToFavoriteBloc(this.addToFavoriteUseCase,this.removeFavoriteProductUseCase,this.getFavoriteProductUseCase) : super(AddToFavoriteInitial()) {
    on<AddToFavoriteEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FavoriteProductEvent>((event, emit) async {
      emit(state.copyWith(
          addToFavoriteRequestState: AddToFavoriteRequestState.loading));

      var result = await addToFavoriteUseCase(event.productId);
      result.fold((l) {
        print(l.message);
        emit(state.copyWith(
            addToFavoriteRequestState: AddToFavoriteRequestState.error,
            addToFavoriteFailures: l));
      }, (r) {
        emit(state.copyWith(
          addToFavoriteRequestState: AddToFavoriteRequestState.success,
         wishlistModel : r,
        ));
        add(GetFavoriteProductEvent());

      });
    });

    on<GetFavoriteProductEvent>((event, emit) async {
      emit(state.copyWith(getFavoriteRequestState: GetFavoriteRequestState.loading));
      var result = await getFavoriteProductUseCase.call();
      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            getFavoriteRequestState: GetFavoriteRequestState.error,
            getFavoriteFailures: error));
      }, (result) {
        print("success response");
        emit(state.copyWith(
            getFavoriteRequestState: GetFavoriteRequestState.success,
            favoriteProductModel : result));
      });
    });

    on<RemoveFavoriteProductEvent>((event, emit) async {
      emit(state.copyWith(removeFavoriteRequestState: RemoveFavoriteRequestState.loading));
      var result = await removeFavoriteProductUseCase.call(event.productId);
      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            removeFavoriteRequestState: RemoveFavoriteRequestState.error,
            removeFavoriteFailures: error));
      }, (result) {
        print("success response");
        emit(state.copyWith(
            removeFavoriteRequestState: RemoveFavoriteRequestState.success,
          deleteFavoriteResponse: result
            ));
        add(GetFavoriteProductEvent());

      });
    });

  }
}
