import 'package:e_commerce_app/core/resources/cache_helper.dart';
import 'package:e_commerce_app/core/routes/auto_route.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/Bloc/add_to_favorite_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => getIt<CartBloc>()..add(GetCartEvent())),
    BlocProvider(create: (_) => getIt<ProductScreenBloc>()),
    BlocProvider(
        create: (_) =>
            getIt<AddToFavoriteBloc>()..add(GetFavoriteProductEvent())),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(430, 932),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp.router(
              routerConfig: _appRouter.config(),
              debugShowCheckedModeBanner: false,
            ));
  }
}
