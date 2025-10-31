abstract class ProductScreenEvent {}

class GetProductsEvent extends ProductScreenEvent {
  final String? subCatId;

  GetProductsEvent({this.subCatId});
}

class AddToCartEvent extends ProductScreenEvent {
  final String? productId;
  final int quantity;

  AddToCartEvent({this.productId, this.quantity = 1});
}

class SearchProduct extends GetProductsEvent {
  final String? query;

  SearchProduct(this.query);
}
class ClearSearchEvent extends ProductScreenEvent {}
