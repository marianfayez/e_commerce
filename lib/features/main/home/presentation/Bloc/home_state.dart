part of 'home_bloc.dart';

enum HomeRequestState { init, loading, error, success }

class HomeState {
  CategoriesModel? categoriesModel;
  RouteFailures? homeRouteFailures;
  HomeRequestState? homeRequestState;

  HomeState(
      {this.homeRequestState, this.categoriesModel, this.homeRouteFailures});

  HomeState copyWith(
      {CategoriesModel? categoriesModel,
      RouteFailures? homeRouteFailures,
      HomeRequestState? homeRequestState}){
    return HomeState(homeRequestState: homeRequestState ?? this.homeRequestState,
    homeRouteFailures: homeRouteFailures ?? this.homeRouteFailures,
    categoriesModel: categoriesModel ?? this.categoriesModel);
  }
}

final class HomeInitial extends HomeState {
  HomeInitial():super(homeRequestState: HomeRequestState.init);
}
