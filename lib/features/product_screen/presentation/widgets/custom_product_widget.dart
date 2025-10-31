import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/widgets/heart_button.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProductWidget extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final String title;
  final String id;
  final String description;
  final double price;
  final double discountPercentage;
  final double rating;
  int? cartItemNum;
  final VoidCallback? onTap;
  final VoidCallback? favoriteOnTab;
  final bool isFavorite;

  CustomProductWidget(
      {super.key,
      required this.width,
      required this.isFavorite,
      required this.onTap,
      required this.favoriteOnTab,
      required this.height,
      required this.image,
      required this.title,
      required this.id,
      required this.description,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      this.cartItemNum});

  String truncateTitle(String title) {
    List<String> words = title.split(' ');
    if (words.length <= 2) {
      return title;
    } else {
      return "${words.sublist(0, 2).join(' ')}..";
    }
  }

  String truncateDescription(String description) {
    List<String> words = description.split(RegExp(r'[\s-]+'));
    if (words.length <= 4) {
      return description;
    } else {
      return "${words.sublist(0, 4).join(' ')}..";
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.4,
        height: height * 0.3,
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.primary.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  // Not working with the lastest flutter version

                  CachedNetworkImage(
                    imageUrl: image,
                    height: height * 0.15,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  // Image.network(
                  //   image,
                  //   fit: BoxFit.cover,
                  // ),
                  // ClipRRect(
                  //   borderRadius:
                  //       BorderRadius.vertical(top: Radius.circular(14.r)),
                  //   child: Image.asset(
                  //     image,
                  //     fit: BoxFit.cover,
                  //     width: width,
                  //   ),
                  // ),
                  Positioned(
                      top: height * 0.01,
                      right: width * 0.02,
                      child: HeartButton(
                          isFavorite: isFavorite, onTap: favoriteOnTab)),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        truncateTitle(title),
                        style: getMediumStyle(
                          color: ColorManager.textColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.002),
                    Expanded(
                      child: Text(
                        truncateDescription(description),
                        maxLines: 1, // Limit the text to one line
                        overflow: TextOverflow.ellipsis,
                        style: getRegularStyle(
                          color: ColorManager.textColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    SizedBox(
                      width: width * 0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "EGP $price",
                              style: getRegularStyle(
                                color: ColorManager.textColor,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "$discountPercentage %",
                              style: getTextWithLine(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(height: height * 0.005),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          // width: width * 0.22,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Review ($rating)",
                                style: getRegularStyle(
                                  color: ColorManager.textColor,
                                  fontSize: 12.sp,
                                ),
                              ),
                              const Icon(
                                Icons.star_rate_rounded,
                                color: ColorManager.starRateColor,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: BlocConsumer<ProductScreenBloc,
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
                              }
                            },
                            builder: (context, state) {
                              return InkWell(
                                onTap: () {
                                  context
                                      .read<ProductScreenBloc>()
                                      .add(AddToCartEvent(productId: id));
                                },
                                child: Container(
                                  height: height * 0.036,
                                  width: width * 0.08,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorManager.primary,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
