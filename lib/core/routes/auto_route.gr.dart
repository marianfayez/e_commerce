// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:e_commerce_app/features/auth/presentation/screens/sign_in_screen.dart'
    as _i5;
import 'package:e_commerce_app/features/auth/presentation/screens/sign_up_screen.dart'
    as _i6;
import 'package:e_commerce_app/features/cart/presentation/screens/cart_screen.dart'
    as _i1;
import 'package:e_commerce_app/features/main/main_screen.dart' as _i2;
import 'package:e_commerce_app/features/product_details/presentation/screens/product_details.dart'
    as _i3;
import 'package:e_commerce_app/features/product_screen/presentation/screens/product_screen.dart'
    as _i4;
import 'package:e_commerce_app/features/splash_screen.dart' as _i7;
import 'package:flutter/material.dart' as _i9;

/// generated route for
/// [_i1.CartScreen]
class CartRoute extends _i8.PageRouteInfo<void> {
  const CartRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CartRoute.name,
          initialChildren: children,
        );

  static const String name = 'CartRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i1.CartScreen();
    },
  );
}

/// generated route for
/// [_i2.MainScreen]
class MainRoute extends _i8.PageRouteInfo<void> {
  const MainRoute({List<_i8.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainScreen();
    },
  );
}

/// generated route for
/// [_i3.ProductDetailsScreen]
class ProductDetailsRoute extends _i8.PageRouteInfo<ProductDetailsRouteArgs> {
  ProductDetailsRoute({
    _i9.Key? key,
    required String productId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ProductDetailsRoute.name,
          args: ProductDetailsRouteArgs(
            key: key,
            productId: productId,
          ),
          rawPathParams: {'productId': productId},
          initialChildren: children,
        );

  static const String name = 'ProductDetailsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProductDetailsRouteArgs>(
          orElse: () => ProductDetailsRouteArgs(
              productId: pathParams.getString('productId')));
      return _i3.ProductDetailsScreen(
        key: args.key,
        productId: args.productId,
      );
    },
  );
}

class ProductDetailsRouteArgs {
  const ProductDetailsRouteArgs({
    this.key,
    required this.productId,
  });

  final _i9.Key? key;

  final String productId;

  @override
  String toString() {
    return 'ProductDetailsRouteArgs{key: $key, productId: $productId}';
  }
}

/// generated route for
/// [_i4.ProductsScreen]
class ProductsRoute extends _i8.PageRouteInfo<ProductsRouteArgs> {
  ProductsRoute({
    _i9.Key? key,
    required String categoryId,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          ProductsRoute.name,
          args: ProductsRouteArgs(
            key: key,
            categoryId: categoryId,
          ),
          rawPathParams: {'categoryId': categoryId},
          initialChildren: children,
        );

  static const String name = 'ProductsRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ProductsRouteArgs>(
          orElse: () => ProductsRouteArgs(
              categoryId: pathParams.getString('categoryId')));
      return _i4.ProductsScreen(
        key: args.key,
        categoryId: args.categoryId,
      );
    },
  );
}

class ProductsRouteArgs {
  const ProductsRouteArgs({
    this.key,
    required this.categoryId,
  });

  final _i9.Key? key;

  final String categoryId;

  @override
  String toString() {
    return 'ProductsRouteArgs{key: $key, categoryId: $categoryId}';
  }
}

/// generated route for
/// [_i5.SignInScreen]
class SignInRoute extends _i8.PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignInRouteArgs>(orElse: () => const SignInRouteArgs());
      return _i5.SignInScreen(key: args.key);
    },
  );
}

class SignInRouteArgs {
  const SignInRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.SignUpScreen]
class SignUpRoute extends _i8.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i9.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignUpRouteArgs>(orElse: () => const SignUpRouteArgs());
      return _i6.SignUpScreen(key: args.key);
    },
  );
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i9.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static _i8.PageInfo page = _i8.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashScreen();
    },
  );
}
