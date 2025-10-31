import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/core/widgets/home_screen_app_bar.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/total_price_and_checkout_botton.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(listener: (context, state) {
      if (state.getCartRequestState == CartRequestState.error) {
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
    }, builder: (context, state) {
      final isCartEmpty = state.cartModel?.data?.products?.isEmpty ?? true;
      if (state.getCartRequestState == GetCartRequestState.loading) {
        return Scaffold(
          appBar: HomeScreenAppBar(
            automaticallyImplyLeading: true,
          ),
          body: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (isCartEmpty) {
        return Scaffold(
            appBar: HomeScreenAppBar(
              automaticallyImplyLeading: true,
            ),
            body: const Center(
              child: Text(
                "Your cart is empty 🛒",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ));
      } else {
        return Scaffold(
          appBar: HomeScreenAppBar(
            automaticallyImplyLeading: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Expanded(
                  // the list of cart items ===============
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<CartBloc>().add(GetCartEvent());
                      await Future.delayed(const Duration(milliseconds: 500));
                    },
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(), // لازم لتمكين السحب حتى لو القائمة قصيرة
                      itemBuilder: (context, index) => CartItemWidget(
                        key: ValueKey(state
                            .cartModel?.data?.products?[index].product?.id),
                        imagePath: state.cartModel?.data?.products?[index]
                                .product?.imageCover ??
                            "",
                        title: state.cartModel?.data?.products?[index].product
                                ?.title ??
                            "",
                        price: int.parse(state
                                .cartModel?.data?.products?[index].price
                                .toString() ??
                            "0"),
                        quantity: int.parse(state
                                .cartModel?.data?.products?[index].count
                                .toString() ??
                            "0"),
                        onDeleteTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Delete Item"),
                              content: const Text(
                                  "Do you want to delete this item from the cart?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Close dialog
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: ()  {
                                     Navigator.pop(context);
                                     context.read<CartBloc>().add(
                                        RemoveCartItemEvent(
                                            productId: state
                                                .cartModel
                                                ?.data
                                                ?.products?[index]
                                                .product
                                                ?.id ??
                                                "",));

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Item removed from cart")),
                                    );
                                     context.read<CartBloc>().add(GetCartEvent());

                                  },
                                  child: const Text("Yes"),
                                ),
                              ],
                            ),
                          );
                        },
                        onDecrementTap: (value) {
                          final product =
                              state.cartModel?.data?.products?[index];
                          final currentQty = product?.count ?? 1;
                          final productId = product?.product?.id ?? "";
                          if (currentQty == 1) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Delete Item"),
                                content: const Text(
                                    "Do you want to delete this item from the cart?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Close dialog
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      context.read<CartBloc>().add(
                                          RemoveCartItemEvent(
                                              productId: productId));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Item removed from cart")),
                                      );
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            context.read<CartBloc>().add(UpdateCartItemEvent(
                                  productId: productId,
                                  newQuantity: currentQty - 1,
                                ));
                          }
                        },
                        onIncrementTap: (value) {
                          final product =
                              state.cartModel?.data?.products?[index];
                          final currentQty = product?.count ?? 1;
                          final productId = product?.product?.id ?? "";

                          if (currentQty >= 1) {
                            context.read<CartBloc>().add(UpdateCartItemEvent(
                                  productId: productId,
                                  newQuantity: currentQty + 1,
                                ));
                          }
                        },
                        size: 40,
                        color: Colors.black,
                        colorName: 'Black',
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 12.h),
                      itemCount: state.cartModel?.data?.products?.length ?? 0,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),

                // the total price and checkout button========
                TotalPriceAndCheckoutBotton(
                  totalPrice: state.cartModel?.data?.totalCartPrice ?? 0,
                  checkoutButtonOnTap: () {},
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      }
    });
  }
}
