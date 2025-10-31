import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/widgets/product_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductRating extends StatelessWidget {
  final String productBuyers;
  final String productRating;
  final String ratingsQuantity;
  final int quantity;
  final formatter = NumberFormat('#,##0', 'en_US');
  final void Function(int value) onIncrementTap;
  final void Function(int value) onDecrementTap;

  ProductRating(
      {super.key,
      required this.onDecrementTap,
        required this.quantity,
        required this.onIncrementTap,
      required this.productBuyers,
      required this.productRating,
      required this.ratingsQuantity});

  @override
  Widget build(BuildContext context) {
    final int buyersCount = int.tryParse(productBuyers) ?? 0;
    final int ratingsCount = int.tryParse(ratingsQuantity) ?? 0;
    final double ratingValue = double.tryParse(productRating) ?? 0.0;

    return Row(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(
                color: ColorManager.primary.withOpacity(.3), width: 1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(
            '${formatter.format(buyersCount)} Sold',
            overflow: TextOverflow.ellipsis,
            style: getMediumStyle(color: ColorManager.primary)
                .copyWith(fontSize: 18.sp),
          ),
        ),
        SizedBox(
          width: 16.w,
        ),
        Image.asset(
          Assets.images.rate.path,
          width: 30.w,
        ),
        SizedBox(
          width: 4.w,
        ),
        Expanded(
          child: Text(
            '${ratingValue.toStringAsFixed(1)} (${formatter.format(ratingsCount)})',
            overflow: TextOverflow.ellipsis,
            style: getMediumStyle(color: ColorManager.appBarTitleColor)
                .copyWith(fontSize: 14.sp),
          ),
        ),
        ProductCounter(
          add: (value) => onIncrementTap(value),
          remove: (value) => onDecrementTap(value),
          productCounter: quantity, // خده من الـ state في ProductDetailsBloc
        )
      ],
    );
  }
}
