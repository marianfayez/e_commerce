import 'package:colornames/colornames.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/widgets/custom_txt_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteItemDetails extends StatelessWidget {
  const FavouriteItemDetails(
      {required this.title,
      required this.price,
      required this.salePrice,
      super.key});

  final String title;
  final num price;
  final num salePrice;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextWgt(
          data: title,
          textStyle: getSemiBoldStyle(
              color: ColorManager.primaryDark, fontSize: 18.sp),
        ),
        // Row(
        //   children: [
        //     Container(
        //       margin: EdgeInsets.only(right: 10.w),
        //       width: 14.w,
        //       height: 14.h,
        //       decoration: BoxDecoration(
        //           color: product["color"], shape: BoxShape.circle),
        //     ),
        //     CustomTextWgt(
        //       data: (product["color"] as Color).colorName,
        //       textStyle: getMediumStyle(
        //           color: ColorManager.primaryDark, fontSize: 14.sp),
        //     ),
        //   ],
        // ),
        Row(
          children: [
            CustomTextWgt(
              data: 'EGP $price  ',
              textStyle: getSemiBoldStyle(
                      color: ColorManager.primaryDark, fontSize: 18.sp)
                  .copyWith(
                letterSpacing: 0.17,
              ),
            ),
            salePrice == null
                ? const SizedBox.shrink()
                : Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomTextWgt(
                            data: 'EGP $salePrice',
                            textStyle: getMediumStyle(
                                    color: ColorManager.appBarTitleColor
                                        .withOpacity(.6))
                                .copyWith(
                                    letterSpacing: 0.17,
                                    decoration: TextDecoration.lineThrough,
                                    color: ColorManager.appBarTitleColor
                                        .withOpacity(.6),
                                    fontSize: 10.sp)),
                      ],
                    ),
                  ),
          ],
        ),
      ],
    );
  }
}
