part of 'cart_bloc.dart';

abstract class CartEvent {}

class GetCartEvent extends CartEvent{

  GetCartEvent();

}
class UpdateCartItemEvent extends CartEvent {
  final String? productId;
  final int newQuantity;

  UpdateCartItemEvent({required this.productId, required this.newQuantity});
}

class RemoveCartItemEvent extends CartEvent {
  final String productId;

  RemoveCartItemEvent({required this.productId});
}