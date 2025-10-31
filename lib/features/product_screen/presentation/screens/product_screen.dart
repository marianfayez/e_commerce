import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/core/widgets/SharedSearchScaffold.dart';
import 'package:e_commerce_app/core/widgets/home_screen_app_bar.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/Bloc/add_to_favorite_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:e_commerce_app/features/product_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductsScreen extends StatelessWidget {
  final String categoryId;

  const ProductsScreen({super.key, @PathParam() required this.categoryId});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocProvider<ProductScreenBloc>(
      create: (context) => getIt<ProductScreenBloc>()
        ..add(GetProductsEvent(subCatId: categoryId)),
      child: BlocListener<AddToFavoriteBloc, AddToFavoriteState>(
          listenWhen: (previous, current) => false,
          listener: (BuildContext context, AddToFavoriteState state) {},
          child: Builder(builder: (context) {
            context.read<AddToFavoriteBloc>().add(GetFavoriteProductEvent());
            return BlocBuilder<AddToFavoriteBloc, AddToFavoriteState>(
                builder: (context, state) {
              final favoriteIds = state.favoriteProductModel?.data != null
                  ? state.favoriteProductModel!.data.map((e) => e.id).toList()
                  : [];

              return BlocConsumer<ProductScreenBloc, ProductScreenState>(
                listener: (context, state) {
                  if (state.getProductsState == ProductRequestState.error) {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: const Text("Error"),
                              content: const Text(
                                "SomeThing went wrong",
                                style: TextStyle(color: Colors.black),
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("ok"))
                              ],
                            ));
                  }
                },
                builder: (context, state) {
                  if (state.getProductsState == ProductRequestState.loading) {
                    return Scaffold(
                      appBar: HomeScreenAppBar(
                        automaticallyImplyLeading: true,

                      ),
                      body: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state.productModel?.data == null ||
                      state.productModel?.data?.isEmpty == true) {
                    return Scaffold(
                      appBar: HomeScreenAppBar(
                        automaticallyImplyLeading: true,
                      ),
                      body: const Center(
                        child: Text(
                          "No data found",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    );
                  } else {
                    return SharedSearchScaffold(
                      automaticallyImplyLeading: true,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                itemCount: state.productModel?.results ?? 0,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                  childAspectRatio: 7 / 9,
                                ),
                                itemBuilder: (context, index) {
                                  final product =
                                      state.productModel!.data![index];
                                  final isFavorite =
                                      favoriteIds.contains(product.id);

                                  return CustomProductWidget(
                                    isFavorite: isFavorite,
                                    favoriteOnTab: () {
                                      isFavorite
                                          ? context
                                              .read<AddToFavoriteBloc>()
                                              .add(RemoveFavoriteProductEvent(
                                                  productId: state.productModel
                                                          ?.data?[index].id ??
                                                      ""))
                                          : context
                                              .read<AddToFavoriteBloc>()
                                              .add(FavoriteProductEvent(
                                                  productId: state.productModel
                                                          ?.data?[index].id ??
                                                      ""));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            isFavorite
                                                ? "Product removed from your wishlist"
                                                : "Product added to your wishlist",
                                          ),
                                        ),
                                      );
                                    },
                                    onTap: () {
                                      context.pushRoute(ProductDetailsRoute(
                                          productId: state.productModel
                                                  ?.data?[index].id ??
                                              ""));
                                    },
                                    id: state.productModel?.data?[index].id ??
                                        "",
                                    image: state.productModel?.data?[index]
                                            .imageCover ??
                                        "",
                                    title: state
                                            .productModel?.data?[index].title ??
                                        "",
                                    price: double.parse(state
                                            .productModel?.data?[index].price
                                            .toString() ??
                                        '0.0'),
                                    rating: double.parse(state.productModel
                                            ?.data?[index].ratingsAverage
                                            .toString() ??
                                        '0.0'),
                                    discountPercentage: double.tryParse(state
                                                .productModel
                                                ?.data?[index]
                                                .priceAfterDiscount
                                                .toString() ??
                                            '0.0') ??
                                        0.0,
                                    height: height,
                                    width: width,
                                    description: state.productModel
                                            ?.data?[index].description ??
                                        "",
                                  );
                                },
                                scrollDirection: Axis.vertical,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            });
          })),
    );
  }
}
