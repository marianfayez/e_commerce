part of 'product_screen_bloc.dart';

enum ProductRequestState { initial, loading, success, error }

enum CartRequestState { initial, loading, success, error }

enum SearchRequestState { initial, loading, success, error }

class ProductScreenState {
  ProductRequestState? getProductsState;
  ProductModel? productModel;
  ProductModel? searchProductsModel;
  RouteFailures? productFailures;
  SearchRequestState? searchRequestState;
  CartRequestState? cartRequestState;
  CartModel? cartModel;
  RouteFailures? cartFailures;
  RouteFailures? searchFailures;

  ProductScreenState(
      { this.searchProductsModel,
      this.getProductsState,
      this.productModel,
      this.productFailures,
      this.cartRequestState,
      this.cartModel,
      this.cartFailures,
        this.searchFailures,
      this.searchRequestState});

  ProductScreenState copyWith(
      {ProductRequestState? getProductsState,
      ProductModel? productModel,
      RouteFailures? productFailures,
        CartRequestState? cartRequestState,
        CartModel? cartModel,
      RouteFailures? searchFailures,
        RouteFailures? cartFailures,
        ProductModel? searchProductsModel,
      SearchRequestState? searchRequestState}) {
    return ProductScreenState(
      searchFailures: searchFailures??this.searchFailures,
      searchRequestState: searchRequestState??this.searchRequestState,
      getProductsState: getProductsState ?? this.getProductsState,
      productModel: productModel ?? this.productModel,
      productFailures: productFailures ?? this.productFailures,
      cartRequestState: cartRequestState ?? this.cartRequestState,
      cartModel: cartModel ?? this.cartModel,
      cartFailures: cartFailures ?? this.cartFailures,
      searchProductsModel: searchProductsModel ?? this.searchProductsModel,
    );
  }
}

class ProductScreenInitial extends ProductScreenState {
  ProductScreenInitial() : super( getProductsState: ProductRequestState.initial,
    searchRequestState: SearchRequestState.initial,
    cartRequestState: CartRequestState.initial,);
}
