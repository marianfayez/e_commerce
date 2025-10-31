import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({required this.onPressed, required this.text, super.key});

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 36.h,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r)),
              padding: EdgeInsets.symmetric(horizontal: 1.w),
              backgroundColor: ColorManager.primary),
          onPressed: onPressed,
          child: Text(text,
              style: getRegularStyle(
                color: ColorManager.white,
                fontSize: 14.sp,
              ))),
    );
  }
}
