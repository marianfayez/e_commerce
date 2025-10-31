part of 'product_details_bloc.dart';

enum ProductDetailsRequestState { initial, loading, success, error }

class ProductDetailsState {
  ProductDetailsRequestState? getProductDetailsState;
  ProductDetailsModel? productDetailsModel;
  RouteFailures? productDetailsFailures;
  final int quantity;

  ProductDetailsState({
    this.getProductDetailsState,
    this.productDetailsModel,
    this.productDetailsFailures,
    this.quantity = 1
  });

  ProductDetailsState copyWith({
    int? quantity,
    ProductDetailsRequestState? getProductDetailsState,
    ProductDetailsModel? productDetailsModel,
    RouteFailures? productDetailsFailures,
  }) {
    return ProductDetailsState(
      quantity: quantity ?? this.quantity,
      getProductDetailsState:
          getProductDetailsState ?? this.getProductDetailsState,
      productDetailsModel: productDetailsModel ?? this.productDetailsModel,
      productDetailsFailures:
          productDetailsFailures ?? this.productDetailsFailures,
    );
  }
}

final class ProductDetailsInitial extends ProductDetailsState {
  ProductDetailsInitial()
      : super(getProductDetailsState: ProductDetailsRequestState.initial);
}
