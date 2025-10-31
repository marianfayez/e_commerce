import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/widgets/heart_button.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/widgets/add_to_cart_button.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/widgets/favourite_item_details.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key, required this.title,
    required this.price, required this.favoriteOnTab, required this.id,
    required this.salePrice, required this.image});

  final String image;
  final String title;
  final num price;
  final num salePrice;
  final VoidCallback? favoriteOnTab;
  final String id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 135.h,
        padding: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: ColorManager.primary.withOpacity(.3))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border:
                  Border.all(color: ColorManager.primary.withOpacity(.6))),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: CachedNetworkImage(
                  width: 120.w,
                  height: 135.h,
                  fit: BoxFit.cover,
                  imageUrl: image,
                  placeholder: (context, url) =>
                      Center(
                        child: CircularProgressIndicator(
                          color: ColorManager.primary,
                        ),
                      ),
                  errorWidget: (context, url, error) =>
                      Icon(
                        Icons.error,
                        color: ColorManager.primary,
                      ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 8.w),
                    child: FavouriteItemDetails(
                      title: title,
                      price: price,
                      salePrice: salePrice,
                    ))),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                HeartButton(isFavorite: true,
                  onTap:
                  favoriteOnTab,),
                SizedBox(height: 14.h),
                BlocConsumer<ProductScreenBloc,
                    ProductScreenState>(
                  listener: (context, state) {
                    if (state.cartRequestState ==
                        CartRequestState.success) {
                      context.read<CartBloc>().add(GetCartEvent());
                      final messenger = ScaffoldMessenger.of(context);
                      messenger.hideCurrentSnackBar();
                      messenger.showSnackBar(
                        SnackBar(
                            content: Text(state.cartModel?.message ??
                                'Added to cart')),
                      );
                    } else if (state.cartRequestState ==
                        CartRequestState.error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                            Text(state.cartModel?.message ?? "")),
                      );
                    }                  },
                  builder: (context, state) {
                    return AddToCartButton(
                      onPressed: (){
                        context
                            .read<ProductScreenBloc>()
                            .add(AddToCartEvent(productId: id));
                      },
                      text: AppConstants.addToCart,
                    );
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
