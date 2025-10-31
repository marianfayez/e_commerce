import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/widgets/SharedSearchScaffold.dart';
import 'package:e_commerce_app/core/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/core/widgets/home_screen_app_bar.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/product_details/presentation/bloc/product_details_bloc.dart';
import 'package:e_commerce_app/features/product_details/presentation/widgets/product_color.dart';
import 'package:e_commerce_app/features/product_details/presentation/widgets/product_description.dart';
import 'package:e_commerce_app/features/product_details/presentation/widgets/product_item.dart';
import 'package:e_commerce_app/features/product_details/presentation/widgets/product_label.dart';
import 'package:e_commerce_app/features/product_details/presentation/widgets/product_rating.dart';
import 'package:e_commerce_app/features/product_details/presentation/widgets/product_size.dart';
import 'package:e_commerce_app/features/product_details/presentation/widgets/product_slider.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

@RoutePage()
class ProductDetailsScreen extends StatelessWidget {
  final String productId;

  ProductDetailsScreen({super.key, @PathParam() required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProductDetailsBloc>()..add(GetProductDetailsEvent(productId)),
      child: BlocBuilder<CartBloc, CartState>(
  builder: (context, state) {
    return BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
        listener: (context, state) {
          AppConstants.loadingDialog(context, state.getProductDetailsState==ProductDetailsRequestState.loading);
        },
        builder: (context, state) {
          var product = state.productDetailsModel?.data;
          return SharedSearchScaffold(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 50.h),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductSlider(
                          items: (product?.images ?? [])
                              .map(
                                  (imageUrl) => ProductItem(imageUrl: imageUrl))
                              .toList(),
                          initialIndex: 0),
                      SizedBox(
                        height: 24.h,
                      ),
                      ProductLabel(
                        productName: product?.title ?? "",
                        productPrice: product?.price.toString() ?? "0",
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ProductRating(
                        productBuyers: product?.sold.toString() ?? "0",
                        productRating:
                            product?.ratingsAverage.toString() ?? "0.0",
                        ratingsQuantity:
                            product?.ratingsQuantity.toString() ?? "0",
                        onDecrementTap: (value) {
                          context.read<ProductDetailsBloc>().add(DecrementQuantityEvent());
                        },
                        onIncrementTap: (value) {
                          context.read<ProductDetailsBloc>().add(IncrementQuantityEvent());

                        },
                        quantity: state.quantity,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ProductDescription(
                          productDescription: product?.description ?? ""),
                      // ProductSize(
                      //   size: const [35, 38, 39, 40],
                      //   onSelected: () {},
                      // ),
                      // SizedBox(
                      //   height: 20.h,
                      // ),
                      // Text('Color',
                      //     style: getMediumStyle(
                      //             color: ColorManager.appBarTitleColor)
                      //         .copyWith(fontSize: 18.sp)),
                      // ProductColor(color: const [
                      //   Colors.red,
                      //   Colors.blueAccent,
                      //   Colors.green,
                      //   Colors.yellow,
                      // ], onSelected: () {}),
                      SizedBox(
                        height: 48.h,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                'Total price',
                                style: getMediumStyle(
                                        color: ColorManager.primary
                                            .withOpacity(.6))
                                    .copyWith(fontSize: 18.sp),
                              ),
                              SizedBox(
                                height: 12.h,
                              ),
                              BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                                  var total =
                                      state.cartModel?.data?.totalCartPrice ??
                                          0;
                                  return Text(
                                      'EGP ${NumberFormat('#,##0', 'en_US').format(total)}',
                                      style: getMediumStyle(
                                              color:
                                                  ColorManager.appBarTitleColor)
                                          .copyWith(fontSize: 18.sp));
                                },
                              )
                            ],
                          ),
                          SizedBox(
                            width: 33.w,
                          ),
                          Expanded(
                            child: BlocConsumer<ProductScreenBloc,
                                ProductScreenState>(
                              listener: (context, state) {
                                if (state.cartRequestState ==
                                    CartRequestState.success) {
                                  context.read<CartBloc>().add(GetCartEvent());
                                  final messenger =
                                      ScaffoldMessenger.of(context);
                                  messenger.hideCurrentSnackBar();
                                  messenger.showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            state.cartModel?.message ??
                                                'Added to cart')),
                                  );
                                } else if (state.cartRequestState ==
                                    CartRequestState.error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            state.cartModel?.message ?? "")),
                                  );
                                }
                              },
                              builder: (context, state) {
                                return CustomElevatedButton(
                                  label: 'Add to cart',
                                  onTap: () {
                                    final quantity = context.read<ProductDetailsBloc>().state.quantity;
                                    context.read<ProductScreenBloc>().add(
                                        AddToCartEvent(productId: productId,
                                          quantity: quantity, // 👈 pass quantity here
                                        ));
                                  },
                                  prefixIcon: Icon(
                                    Icons.add_shopping_cart_outlined,
                                    color: ColorManager.white,
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ]),
              ),
            ),
          );
        },
      );
  },
),
    );
  }
}
