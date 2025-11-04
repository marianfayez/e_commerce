// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'core/api/api_manager.dart' as _i237;
import 'features/auth/data/data_sources/remote/auth_remote_ds.dart' as _i981;
import 'features/auth/data/data_sources/remote/auth_remote_ds_impl.dart'
    as _i393;
import 'features/auth/data/repositories/auth_repo_impl.dart' as _i426;
import 'features/auth/domain/repositories/auth_repo.dart' as _i416;
import 'features/auth/domain/use_cases/log_in_use_case.dart' as _i871;
import 'features/auth/domain/use_cases/sign_up_use_cases.dart' as _i606;
import 'features/auth/presentation/bloc/auth_bloc.dart' as _i363;
import 'features/cart/data/data_sources/remote/cart_remote_ds.dart' as _i351;
import 'features/cart/data/data_sources/remote/cart_remote_ds_impl.dart'
    as _i20;
import 'features/cart/data/repositories/cart_repo_impl.dart' as _i305;
import 'features/cart/domain/repositories/get_cart_repo.dart' as _i994;
import 'features/cart/domain/use_cases/cart_use_case.dart' as _i129;
import 'features/cart/domain/use_cases/remove_cart_use_case.dart' as _i316;
import 'features/cart/domain/use_cases/update_cart_use_case.dart' as _i716;
import 'features/cart/presentation/bloc/cart_bloc.dart' as _i239;
import 'features/main/categories/data/data_sources/remote/categories_remote_ds.dart'
    as _i823;
import 'features/main/categories/data/data_sources/remote/categories_remote_ds_impl.dart'
    as _i893;
import 'features/main/categories/data/repositories/categories_repo_impl.dart'
    as _i809;
import 'features/main/categories/domain/repositories/categories_repo.dart'
    as _i68;
import 'features/main/categories/domain/use_cases/categories_use_cases.dart'
    as _i858;
import 'features/main/categories/presentation/Bloc/categories_bloc.dart'
    as _i518;
import 'features/main/favorites/data/data_sources/remote/add_to_favorite_ds.dart'
    as _i981;
import 'features/main/favorites/data/data_sources/remote/add_to_favorite_ds_impl.dart'
    as _i36;
import 'features/main/favorites/data/repositories/add_to_favorite_repo_impl.dart'
    as _i311;
import 'features/main/favorites/domain/repositories/add_to_favorite_repo.dart'
    as _i466;
import 'features/main/favorites/domain/use_cases/add_to_favorite_use_case.dart'
    as _i82;
import 'features/main/favorites/domain/use_cases/get_favorite_product.dart'
    as _i442;
import 'features/main/favorites/domain/use_cases/remove_from_favorite.dart'
    as _i493;
import 'features/main/favorites/presentation/Bloc/add_to_favorite_bloc.dart'
    as _i491;
import 'features/main/home/data/data_sources/remote/home_remote_ds.dart'
    as _i455;
import 'features/main/home/data/data_sources/remote/home_remote_ds_imp.dart'
    as _i997;
import 'features/main/home/data/repositories/home_repo_impl.dart' as _i988;
import 'features/main/home/domain/repositories/home_repo.dart' as _i125;
import 'features/main/home/domain/use_cases/home_use_cases.dart' as _i763;
import 'features/main/home/presentation/Bloc/home_bloc.dart' as _i31;
import 'features/main/profile/data/data_sources/remote/profile_remote_ds.dart'
    as _i543;
import 'features/main/profile/data/data_sources/remote/profile_remote_ds_impl.dart'
    as _i649;
import 'features/main/profile/data/repositories/profile_repo_impl.dart'
    as _i674;
import 'features/main/profile/domain/repositories/profile_repo.dart' as _i639;
import 'features/main/profile/domain/use_cases/add_address_use_case.dart'
    as _i1012;
import 'features/main/profile/domain/use_cases/delete_address_use_case.dart'
    as _i858;
import 'features/main/profile/domain/use_cases/profile_use-case.dart' as _i549;
import 'features/main/profile/presentation/Bloc/profile_bloc.dart' as _i157;
import 'features/product_details/data/data_sources/remote/product_details_ds.dart'
    as _i868;
import 'features/product_details/data/data_sources/remote/product_details_ds_impl.dart'
    as _i153;
import 'features/product_details/data/repositories/product_details_repo_impl.dart'
    as _i406;
import 'features/product_details/domain/repositories/product_details_repo.dart'
    as _i9;
import 'features/product_details/domain/use_cases/product_details_use_case.dart'
    as _i761;
import 'features/product_details/presentation/bloc/product_details_bloc.dart'
    as _i466;
import 'features/product_screen/data/data_sources/remote/product_remote_ds.dart'
    as _i106;
import 'features/product_screen/data/data_sources/remote/product_remote_ds_impl.dart'
    as _i157;
import 'features/product_screen/data/repositories/product_repo_impl.dart'
    as _i82;
import 'features/product_screen/domain/repositories/product_repo.dart' as _i30;
import 'features/product_screen/domain/use_cases/add_to_cart_use_case.dart'
    as _i529;
import 'features/product_screen/domain/use_cases/get_product_use_case.dart'
    as _i35;
import 'features/product_screen/domain/use_cases/search_product_use_case.dart'
    as _i1013;
import 'features/product_screen/presentation/bloc/product_screen_bloc.dart'
    as _i281;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i237.ApiManager>(() => _i237.ApiManager());
    gh.factory<_i981.AuthRemoteDs>(
        () => _i393.AuthRemoteDsImpl(gh<_i237.ApiManager>()));
    gh.factory<_i455.HomeRemoteDs>(
        () => _i997.HomeRemoteDsImpl(gh<_i237.ApiManager>()));
    gh.factory<_i981.AddToFavoriteDs>(
        () => _i36.AddToFavoriteDsImpl(gh<_i237.ApiManager>()));
    gh.factory<_i823.CategoriesRemoteDs>(
        () => _i893.CategoriesRemoteDsImpl(gh<_i237.ApiManager>()));
    gh.factory<_i351.CartRemoteDs>(
        () => _i20.CartRemoteDsImpl(gh<_i237.ApiManager>()));
    gh.factory<_i543.ProfileRemoteDs>(
        () => _i649.ProfileRemoteDsImpl(gh<_i237.ApiManager>()));
    gh.factory<_i68.CategoriesRepo>(
        () => _i809.CategoriesRepoImpl(gh<_i823.CategoriesRemoteDs>()));
    gh.factory<_i416.AuthRepo>(
        () => _i426.AuthRepoImpl(gh<_i981.AuthRemoteDs>()));
    gh.factory<_i106.ProductRemoteDs>(
        () => _i157.ProductRemoteDsImpl(gh<_i237.ApiManager>()));
    gh.factory<_i868.ProductDetailsDs>(
        () => _i153.ProductDetailsDsImpl(gh<_i237.ApiManager>()));
    gh.factory<_i871.LogInUseCase>(
        () => _i871.LogInUseCase(gh<_i416.AuthRepo>()));
    gh.factory<_i606.SignUpUseCases>(
        () => _i606.SignUpUseCases(gh<_i416.AuthRepo>()));
    gh.factory<_i125.HomeRepo>(
        () => _i988.HomeRepoImpl(gh<_i455.HomeRemoteDs>()));
    gh.factory<_i858.CategoriesUseCases>(
        () => _i858.CategoriesUseCases(gh<_i68.CategoriesRepo>()));
    gh.factory<_i9.ProductDetailsRepo>(
        () => _i406.ProductDetailsRepoImpl(gh<_i868.ProductDetailsDs>()));
    gh.factory<_i363.AuthBloc>(() => _i363.AuthBloc(
          gh<_i606.SignUpUseCases>(),
          gh<_i871.LogInUseCase>(),
        ));
    gh.factory<_i761.ProductDetailsUseCase>(
        () => _i761.ProductDetailsUseCase(gh<_i9.ProductDetailsRepo>()));
    gh.factory<_i466.FavoriteRepo>(
        () => _i311.AddToFavoriteRepoImpl(gh<_i981.AddToFavoriteDs>()));
    gh.factory<_i30.ProductRepo>(
        () => _i82.ProductRepoImpl(gh<_i106.ProductRemoteDs>()));
    gh.factory<_i994.GetCartRepo>(
        () => _i305.CartRepoImpl(gh<_i351.CartRemoteDs>()));
    gh.factory<_i763.HomeUseCases>(
        () => _i763.HomeUseCases(gh<_i125.HomeRepo>()));
    gh.factory<_i31.HomeBloc>(() => _i31.HomeBloc(gh<_i763.HomeUseCases>()));
    gh.factory<_i442.GetFavoriteProductUseCase>(
        () => _i442.GetFavoriteProductUseCase(gh<_i466.FavoriteRepo>()));
    gh.factory<_i493.RemoveFromFavorite>(
        () => _i493.RemoveFromFavorite(gh<_i466.FavoriteRepo>()));
    gh.factory<_i639.ProfileRepo>(
        () => _i674.ProfileRepoImpl(gh<_i543.ProfileRemoteDs>()));
    gh.factory<_i466.ProductDetailsBloc>(
        () => _i466.ProductDetailsBloc(gh<_i761.ProductDetailsUseCase>()));
    gh.factory<_i1012.AddAddressUseCase>(
        () => _i1012.AddAddressUseCase(gh<_i639.ProfileRepo>()));
    gh.factory<_i858.DeleteAddressUseCase>(
        () => _i858.DeleteAddressUseCase(gh<_i639.ProfileRepo>()));
    gh.factory<_i529.AddToCartUseCase>(
        () => _i529.AddToCartUseCase(gh<_i30.ProductRepo>()));
    gh.factory<_i35.GetProductUseCase>(
        () => _i35.GetProductUseCase(gh<_i30.ProductRepo>()));
    gh.factory<_i1013.SearchProductUseCase>(
        () => _i1013.SearchProductUseCase(gh<_i30.ProductRepo>()));
    gh.factory<_i82.AddToFavoriteUseCase>(
        () => _i82.AddToFavoriteUseCase(gh<_i466.FavoriteRepo>()));
    gh.factory<_i129.CartUseCase>(
        () => _i129.CartUseCase(gh<_i994.GetCartRepo>()));
    gh.factory<_i316.RemoveCartUseCase>(
        () => _i316.RemoveCartUseCase(gh<_i994.GetCartRepo>()));
    gh.factory<_i716.UpdateCartUseCase>(
        () => _i716.UpdateCartUseCase(gh<_i994.GetCartRepo>()));
    gh.factory<_i518.CategoriesBloc>(() => _i518.CategoriesBloc(
          gh<_i763.HomeUseCases>(),
          gh<_i858.CategoriesUseCases>(),
        ));
    gh.factory<_i281.ProductScreenBloc>(() => _i281.ProductScreenBloc(
          gh<_i35.GetProductUseCase>(),
          gh<_i529.AddToCartUseCase>(),
          gh<_i1013.SearchProductUseCase>(),
        ));
    gh.factory<_i239.CartBloc>(() => _i239.CartBloc(
          gh<_i129.CartUseCase>(),
          gh<_i316.RemoveCartUseCase>(),
          gh<_i716.UpdateCartUseCase>(),
        ));
    gh.factory<_i549.ProfileUseCase>(
        () => _i549.ProfileUseCase(gh<_i639.ProfileRepo>()));
    gh.factory<_i157.ProfileBloc>(() => _i157.ProfileBloc(
          gh<_i549.ProfileUseCase>(),
          gh<_i1012.AddAddressUseCase>(),
          gh<_i858.DeleteAddressUseCase>(),
        ));
    gh.factory<_i491.AddToFavoriteBloc>(() => _i491.AddToFavoriteBloc(
          gh<_i82.AddToFavoriteUseCase>(),
          gh<_i493.RemoveFromFavorite>(),
          gh<_i442.GetFavoriteProductUseCase>(),
        ));
    return this;
  }
}
