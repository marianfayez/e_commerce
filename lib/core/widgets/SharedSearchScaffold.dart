import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/core/widgets/home_screen_app_bar.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/Bloc/add_to_favorite_bloc.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/widgets/favourite_item.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:e_commerce_app/features/product_screen/presentation/widgets/custom_product_search_widget.dart';
import 'package:e_commerce_app/features/product_screen/presentation/widgets/custom_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SharedSearchScaffold extends StatelessWidget {
  final Widget child;
  final bool automaticallyImplyLeading;
  final TextEditingController _searchController = TextEditingController();

  SharedSearchScaffold({
    super.key,
    required this.child,
    this.automaticallyImplyLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocListener<ProductScreenBloc, ProductScreenState>(
      listenWhen: (prev, curr) =>
          prev.searchRequestState != curr.searchRequestState,
      listener: (context, state) {
        if (state.searchRequestState == SearchRequestState.initial) {
          _searchController.clear();
        }
      },
      child: Scaffold(
        appBar: HomeScreenAppBar(
          searchController: _searchController,
          automaticallyImplyLeading: automaticallyImplyLeading,
        ),
        body: BlocBuilder<ProductScreenBloc, ProductScreenState>(
          builder: (context, state) {
            var searchResults = state.searchProductsModel?.data;
            var allProducts = state.productModel?.data;

            final isSearchSuccess =
                state.searchRequestState == SearchRequestState.success;
            final isGetSuccess =
                state.getProductsState == ProductRequestState.success;

            final isSearching =
                state.searchRequestState != SearchRequestState.initial;

            if (state.searchRequestState == SearchRequestState.loading ||
                state.getProductsState == ProductRequestState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            final results = isSearchSuccess
                ? searchResults
                : isGetSuccess
                    ? allProducts
                    : [];

            if (isSearching && (results == null || results.isEmpty)) {
              return const Center(child: Text("لا يوجد نتائج"));
            }

            if (isSearching && results != null) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                itemCount: results.length,
                itemBuilder: (context, index) {

                  final product = results[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h),
                    child: CustomProductSearchWidget(
                      onTap: () {
                        context.read<ProductScreenBloc>().add(ClearSearchEvent());
                        context.pushRoute(ProductDetailsRoute(
                            productId: product.id ??
                                ""));
                      },
                      id: product.id ??
                          "",
                      image: product
                          .imageCover ??
                          "",
                      title: product.title ??
                          "",
                      price: double.parse(product.price
                          .toString() ??
                          '0.0'),
                      rating: double.parse(product.ratingsAverage
                          .toString() ??
                          '0.0'),

                      width: width * 0.9,
                      height: 120.h,

                    ),
                  );
                },
              );
            }

            return child;
          },
        ),
      ),
    );
  }
}
