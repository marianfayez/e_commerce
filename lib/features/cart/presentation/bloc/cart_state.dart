part of 'cart_bloc.dart';


enum GetCartRequestState { init, loading, error, success }
enum RemoveItemRequestState { init, loading, error, success }
enum UpdateCartRequestState { init, loading, error, success }

 class CartState {
   CartModel? cartModel;
   RouteFailures? getCartRouteFailures;
   RouteFailures? updateCartRouteFailures;
   RouteFailures? removeItemRouteFailures;

   GetCartRequestState? getCartRequestState;
   UpdateCartRequestState? updateCartRequestState;
   RemoveItemRequestState? removeItemRequestState;

   CartState(
       {this.getCartRequestState, this.cartModel, this.getCartRouteFailures,
       this.updateCartRequestState,this.removeItemRequestState,this.removeItemRouteFailures,this.updateCartRouteFailures});

   CartState copyWith(
       {CartModel? cartModel,
         RouteFailures? getCartRouteFailures,
         GetCartRequestState? getCartRequestState,
         UpdateCartRequestState? updateCartRequestState,RemoveItemRequestState? removeItemRequestState,
         RouteFailures? removeItemRouteFailures,RouteFailures? updateCartRouteFailures}){
     return CartState(getCartRequestState: getCartRequestState ?? this.getCartRequestState,
         getCartRouteFailures: getCartRouteFailures ?? this.getCartRouteFailures,
         cartModel: cartModel ?? this.cartModel,
       removeItemRouteFailures: removeItemRouteFailures ?? this.removeItemRouteFailures,
       updateCartRouteFailures: updateCartRouteFailures ?? this.updateCartRouteFailures,
       updateCartRequestState: updateCartRequestState ?? this.updateCartRequestState,
       removeItemRequestState: removeItemRequestState ?? this.removeItemRequestState,
     );
   }
 }

final class CartInitial extends CartState {
  CartInitial():super(getCartRequestState: GetCartRequestState.init);
}
