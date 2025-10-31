import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/product_details/data/model/product_details_model.dart';
import 'package:e_commerce_app/features/product_details/domain/use_cases/product_details_use_case.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

@injectable
class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductDetailsUseCase productDetailsUseCase;
  ProductDetailsBloc(this.productDetailsUseCase) : super(ProductDetailsInitial()) {
    on<ProductDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetProductDetailsEvent>((event, emit) async{
      emit(state.copyWith(getProductDetailsState: ProductDetailsRequestState.loading));

      var result = await productDetailsUseCase(event.productId);
      result.fold((l) {
        print(l.message);
        emit(state.copyWith(
            getProductDetailsState: ProductDetailsRequestState.error, productDetailsFailures: l));
      }, (r) {
        emit(state.copyWith(
          getProductDetailsState: ProductDetailsRequestState.success,
          productDetailsModel: r,
        ));
      });
    });
    on<IncrementQuantityEvent>((event, emit) {
      emit(state.copyWith(quantity: state.quantity + 1));
    });

    on<DecrementQuantityEvent>((event, emit) {
      int newQuantity = (state.quantity > 1) ? state.quantity - 1 : 1;
      emit(state.copyWith(quantity: newQuantity));
    });
  }
}
