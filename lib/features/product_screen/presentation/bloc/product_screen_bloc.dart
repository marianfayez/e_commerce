import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/product_screen/data/models/CartModel.dart';
import 'package:e_commerce_app/features/product_screen/data/models/product_model.dart';
import 'package:e_commerce_app/features/product_screen/domain/use_cases/add_to_cart_use_case.dart';
import 'package:e_commerce_app/features/product_screen/domain/use_cases/get_product_use_case.dart';
import 'package:e_commerce_app/features/product_screen/domain/use_cases/search_product_use_case.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'product_screen_state.dart';

@injectable
class ProductScreenBloc extends Bloc<ProductScreenEvent, ProductScreenState> {

  final GetProductUseCase getProductUseCase;
  final AddToCartUseCase addToCartUseCase;
  final SearchProductUseCase searchProductUseCase;

  ProductScreenBloc(this.getProductUseCase,this.addToCartUseCase,this.searchProductUseCase) : super(ProductScreenInitial()) {
    on<ProductScreenEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetProductsEvent>((event, emit) async {
      emit(state.copyWith(getProductsState: ProductRequestState.loading));

      var result = await getProductUseCase(catId: event.subCatId);
      result.fold((l) {
        print(l.message);
        emit(state.copyWith(
            getProductsState: ProductRequestState.error, productFailures: l));
      }, (r) {
        emit(state.copyWith(
          getProductsState: ProductRequestState.success,
          productModel: r,
        ));
      });
    });

    on<SearchProduct>((event, emit) async {
      emit(state.copyWith(searchRequestState: SearchRequestState.loading));

      var result = await searchProductUseCase(query: event.query);
      result.fold((l) {
        print(l.message);
        emit(state.copyWith(
            searchRequestState: SearchRequestState.error, searchFailures: l));
      }, (r) {
        final query = event.query!.toLowerCase();
        final allProducts = state.productModel?.data ?? [];

        final filtered = allProducts.where((product) =>
            product.title!.toLowerCase().contains(query)??false).toList();
        emit(state.copyWith(
          searchRequestState: SearchRequestState.success,
          searchProductsModel: ProductModel(
            data: filtered,
            results: filtered.length,
          ),
        ));
      });
    });

    on<ClearSearchEvent>((event, emit) {
      emit(state.copyWith(searchRequestState: SearchRequestState.initial,searchProductsModel: null));
    });

    on<AddToCartEvent>((event, emit) async {
      emit(state.copyWith(cartRequestState: CartRequestState.loading));

      var result = await addToCartUseCase(productId: event.productId);
      result.fold((l) {
        print(l.message);
        emit(state.copyWith(
            cartRequestState: CartRequestState.error, cartFailures: l));
      }, (r) {
        print(r.message);
        if (event.quantity > 1) {
          getIt<CartBloc>().add(UpdateCartItemEvent(
            productId: event.productId,
            newQuantity: event.quantity,
          ));
        }
        emit(state.copyWith(
          cartRequestState: CartRequestState.success,
          cartModel: r,
        ));

      });
    });

  }
}
