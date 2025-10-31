import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/Bloc/add_to_favorite_bloc.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/widgets/favourite_item.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddToFavoriteBloc, AddToFavoriteState>(
      listener: (context, state) {
        if (state.getFavoriteRequestState == GetFavoriteRequestState.error) {
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
        if (state.getFavoriteRequestState == GetFavoriteRequestState.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        final isEmpty = state.favoriteProductModel?.data.isEmpty ?? true;
        if (isEmpty) {
          return const Center(
            child: Text(
              "There is no favorite product",
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        } else {
          var product = state.favoriteProductModel;
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              child: RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<AddToFavoriteBloc>()
                      .add(GetFavoriteProductEvent());
                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: ListView.builder(
                  itemCount: state.favoriteProductModel?.count ?? 0,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: FavoriteItem(
                        image: product?.data[index].imageCover ?? "",
                        title: product?.data[index].title ?? "",
                        price: product?.data[index].price ?? 0.0,
                        salePrice:
                            product?.data[index].priceAfterDiscount ?? 0,
                        favoriteOnTab: () {
                          context.read<AddToFavoriteBloc>().add(
                              RemoveFavoriteProductEvent(
                                  productId: product?.data[index].id ?? ""));
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Product removed from your wishlist"
                              ),
                            ),
                          );
                        },
                        id:product?.data[index].id ?? "" ,

                      ),
                    );
                  },
                ),
              ));
        }
      },
    );
  }
}
