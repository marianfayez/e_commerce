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

class CustomProductSearchWidget extends StatelessWidget {
  final double width;
  final double height;
  final String image;
  final String title;
  final String id;
  final double price;
  final double rating;
  int? cartItemNum;
  final VoidCallback? onTap;


  CustomProductSearchWidget(
      {super.key,
      required this.width,
      required this.onTap,
      required this.height,
      required this.image,
      required this.title,
      required this.id,
      required this.price,
      required this.rating,
      this.cartItemNum});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        height: 120.h,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(
            color: ColorManager.primary.withOpacity(0.3),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: image,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: getMediumStyle(
                      color: ColorManager.textColor,
                      fontSize: 12.sp,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "EGP $price",
                        style: getRegularStyle(
                          color: ColorManager.textColor,
                          fontSize: 13.sp,
                        ),
                      ),

                    ],
                  ),
                  // SizedBox(height: height * 0.005),
                  Row(
                    children: [
                      Text(
                        "Review ($rating)",
                        style: getRegularStyle(
                          color: ColorManager.textColor,
                          fontSize: 11.sp,
                        ),
                      ),
                      const Icon(
                        Icons.star_rate_rounded,
                        color: ColorManager.starRateColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
