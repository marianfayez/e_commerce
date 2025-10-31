import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/cart/domain/use_cases/cart_use_case.dart';
import 'package:e_commerce_app/features/cart/domain/use_cases/remove_cart_use_case.dart';
import 'package:e_commerce_app/features/cart/domain/use_cases/update_cart_use_case.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';

part 'cart_state.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartUseCase cartUseCase;
  RemoveCartUseCase removeCartUseCase;
  UpdateCartUseCase updateCartUseCase;

  CartBloc(this.cartUseCase, this.removeCartUseCase, this.updateCartUseCase)
      : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetCartEvent>((event, emit) async {
      emit(state.copyWith(getCartRequestState: GetCartRequestState.loading));
      var result = await cartUseCase.call();
      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            getCartRequestState: GetCartRequestState.error,
            getCartRouteFailures: error));
      }, (result) {
        print("success response");
        emit(state.copyWith(
            getCartRequestState: GetCartRequestState.success,
            cartModel: result));
      });
    });

    on<UpdateCartItemEvent>((event, emit) async {
      emit(state.copyWith(
          updateCartRequestState: UpdateCartRequestState.loading));
      var result =
          await updateCartUseCase.call(event.productId, event.newQuantity);
      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            updateCartRequestState: UpdateCartRequestState.error,
            getCartRouteFailures: error));
      }, (result) {
        print("success response");
        emit(state.copyWith(
            updateCartRequestState: UpdateCartRequestState.success,
            cartModel: result));
      });
    });

    on<RemoveCartItemEvent>((event, emit) async {
      emit(state.copyWith(
          removeItemRequestState: RemoveItemRequestState.loading));
      var result = await removeCartUseCase.call(event.productId);
      return result.fold((error) {
        print("error response");
        print("❌ Error: $error");

        emit(state.copyWith(
            removeItemRequestState: RemoveItemRequestState.error,
            getCartRouteFailures: error));
      }, (success) async {
        print("✅ Item removed, now refreshing...");

        // بعد نجاح الحذف، نعيد تحميل السلة مباشرة
        final refreshedCart = await cartUseCase.call();
        refreshedCart.fold((err) {
          emit(state.copyWith(
            getCartRequestState: GetCartRequestState.error,
            getCartRouteFailures: err,
          ));
        }, (updatedCart) async {
          print("✅ Item removed successfully");
          emit(state.copyWith(
            removeItemRequestState: RemoveItemRequestState.success,
            getCartRequestState: GetCartRequestState.success,
            cartModel: updatedCart,
          ));
        });
      });
    });
  }
}
