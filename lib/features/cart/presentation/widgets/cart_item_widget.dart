
import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/widgets/product_counter.dart';
import 'package:e_commerce_app/features/cart/presentation/widgets/color_and_size_cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.color,
    required this.colorName,
    required this.size,
    required this.price,
    required this.onDeleteTap,
    required this.quantity,
    required this.onIncrementTap,
    required this.onDecrementTap,
  });
  final String imagePath;
  final String title;
  final Color color;
  final String colorName;
  final int size;
  final int price;
  final void Function() onDeleteTap;
  final int quantity;
  final void Function(int value) onIncrementTap;
  final void Function(int value) onDecrementTap;
  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {

      },
      child: Container(
        height: isPortrait ? height * 0.14 : width * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: ColorManager.primary.withOpacity(0.3)),
        ),
        child: Row(children: [
          // display image in the container
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: ColorManager.primary.withOpacity(0.3)),
            ),
            child: Image.network(
              imagePath,
              fit: BoxFit.cover,
              height: isPortrait ? height * 0.142 : height * 0.23,
              width: isPortrait ? width * 0.29 : 165.w,
            ),
          ),
          // SizedBox(width: 8.w),
          // display details product=========================
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 8.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // title and delete button ==
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getBoldStyle(
                            color: ColorManager.textColor,
                            fontSize:18.sp,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: onDeleteTap,
                        child: Image.asset(
                          Assets.icons.icDelete.path,
                          color: ColorManager.textColor,
                          height: 22.h,
                        ),
                      )
                    ],
                  ),

                  // SizedBox(height: 7.h),
                  const Spacer(),
                  // display color and size===================
                  ColorAndSizeCartItem(
                    color: color,
                    colorName: colorName,
                    size: size,
                  ),
                  const Spacer(),
                  // display price and quantity =================
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'EGP $price',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getBoldStyle(
                              color: ColorManager.textColor,
                              fontSize:18.sp),
                        ),
                      ),
                      ProductCounter(
                        add: onIncrementTap,
                        productCounter: quantity,
                        remove: onDecrementTap,
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
