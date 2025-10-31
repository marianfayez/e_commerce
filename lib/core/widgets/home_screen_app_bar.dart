import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? automaticallyImplyLeading;
  final TextEditingController? searchController;


   HomeScreenAppBar(
      {super.key,  this.automaticallyImplyLeading,this.searchController});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      title: SvgPicture.asset(
        Assets.svgImages.route,
        height: 25.h,
        width: 25.w,
        colorFilter:
        const ColorFilter.mode(ColorManager.textColor, BlendMode.srcIn),
      ),
      bottom: PreferredSize(
          preferredSize: const Size(100, 60),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        cursorColor: ColorManager.primary,
                        style: getRegularStyle(
                            color: ColorManager.primary, fontSize: FontSize.s16),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 8.h),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10000),
                              borderSide: BorderSide(
                                  width: 1, color: ColorManager.primary)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10000),
                              borderSide: BorderSide(
                                  width: 1, color: ColorManager.primary)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10000),
                              borderSide: BorderSide(
                                  width: 1, color: ColorManager.primary)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10000),
                              borderSide: BorderSide(
                                  width: 1, color: ColorManager.primary)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10000),
                              borderSide: BorderSide(
                                  width: 1, color: ColorManager.error)),
                          prefixIcon: ImageIcon(
                            AssetImage(Assets.icons.icSearch.path),
                            color: ColorManager.primary,
                          ),
                          hintText: "what do you search for?",
                          hintStyle: getRegularStyle(
                              color: ColorManager.primary, fontSize: FontSize.s16),
                        ),
                        onChanged: (text){
                          if (text.isEmpty) {
                            context.read<ProductScreenBloc>().add(ClearSearchEvent());
                          } else {
                            context.read<ProductScreenBloc>().add(SearchProduct(text));
                          }                        },
                      ),
                    ),
                    // Products List / Loading / Empty
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Badge(
                          label: Text(state.cartModel?.numOfCartItems?.toString()??""),
                          padding: const EdgeInsets.all(4),
                          alignment: Alignment.topLeft,
                          child: IconButton(
                              onPressed: () {
                                context.pushRoute(CartRoute());
                              },
                              icon: const Icon(Icons.shopping_cart_outlined)),
                        );
                      },
                    )
                  ],
                ),


              ],
            ),


          )),
      // leading: const SizedBox.shrink(),
    );
  }

  @override
  Size get preferredSize => Size(0, 130.h);
}
