import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/failuers/failuers.dart';
import 'package:e_commerce_app/features/main/home/data/models/CategoriesModel.dart';
import 'package:e_commerce_app/features/main/home/domain/use_cases/home_use_cases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeUseCases homeUseCases;

  static HomeBloc get(context) => BlocProvider.of(context);

  HomeBloc(this.homeUseCases) : super(HomeInitial()) {
    on<CategoriesEvent>((event, emit) async{
      emit(state.copyWith(homeRequestState: HomeRequestState.loading));
      var result = await homeUseCases.call();
      return result.fold((error){
        print("error response");
        emit(state.copyWith(homeRequestState: HomeRequestState.error,homeRouteFailures:error));
      }, (result){
        print("success response");
        emit(state.copyWith(homeRequestState: HomeRequestState.success,categoriesModel:result));
      });
    });
  }
}
