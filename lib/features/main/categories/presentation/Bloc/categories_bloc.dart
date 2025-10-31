import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/main/categories/domain/use_cases/categories_use_cases.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:e_commerce_app/features/main/home/domain/use_cases/home_use_cases.dart';
import 'package:e_commerce_app/features/main/home/presentation/Bloc/home_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'categories_event.dart';
part 'categories_state.dart';
part 'categories_bloc.freezed.dart';

@injectable
class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  HomeUseCases homeUseCases;
  CategoriesUseCases categoriesUseCases;
  CategoriesBloc(this.homeUseCases,this.categoriesUseCases) : super(const CategoriesState.initial()) {
    on<CategoriesEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetCategoriesEvent>((event,emit)async{
      emit(state.copyWith(getCategoriesState: HomeRequestState.loading));
      var result= await homeUseCases();
      return result.fold((error){
        print("error response");
        emit(state.copyWith(getCategoriesState: HomeRequestState.error,fail:error));
      }, (result){
        print("success response");
        emit(state.copyWith(getCategoriesState: HomeRequestState.success,model:result));
        add(GetSubCategoriesEvent(result.data?.first.id??""));
      });
    });

    on<GetSubCategoriesEvent>((event,emit)async{
      emit(state.copyWith(getSubCategoriesState: HomeRequestState.loading));
      var result= await categoriesUseCases(event.catId);
      return result.fold((error){
        print("error response");
        emit(state.copyWith(getSubCategoriesState: HomeRequestState.error,subFail:error));
      }, (result){
        print("success response");
        emit(state.copyWith(getSubCategoriesState: HomeRequestState.success,subModel:result));
      });
    });

    on<ChangeSelectedIndexEvent>((event,emit){
      emit(state.copyWith(selectedIndex: event.index));
      add(GetSubCategoriesEvent(state.model?.data?[state.selectedIndex].id??""));
    });

  }
}
