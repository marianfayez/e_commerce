part of 'product_details_bloc.dart';

 class ProductDetailsEvent {}

class GetProductDetailsEvent extends ProductDetailsEvent{

  final String productId;
  GetProductDetailsEvent(this.productId);
}
class IncrementQuantityEvent extends ProductDetailsEvent {}

class DecrementQuantityEvent extends ProductDetailsEvent {}
