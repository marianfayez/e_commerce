import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/features/product_details/presentation/screens/product_details.dart';
import 'package:e_commerce_app/features/product_screen/presentation/screens/product_screen.dart';


@AutoRouterConfig()
class AppRouter extends RootStackRouter {

  @override
  List<AutoRoute> get routes => [

    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: MainRoute.page),
    AutoRoute(page: ProductsRoute.page),
    AutoRoute(page: CartRoute.page),
    AutoRoute(page: ProductDetailsRoute.page),

  ];
}

