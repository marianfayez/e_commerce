part of 'categories_bloc.dart';

@freezed
class CategoriesState with _$CategoriesState {
  const factory CategoriesState.initial(
  {CategoriesModel? model,
    RouteFailures? fail,
    @Default(0)int selectedIndex,
  @Default(HomeRequestState.init)HomeRequestState getCategoriesState,
  RouteFailures? subFail,
  CategoriesModel? subModel,
    @Default(HomeRequestState.init)HomeRequestState getSubCategoriesState
  }
      ) = _Initial;
}
