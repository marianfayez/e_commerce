import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProductLabel extends StatelessWidget {
  ProductLabel(
      {super.key, required this.productName, required this.productPrice});

  final String productName;
  final String productPrice;
  final formatter = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    final double? price = double.tryParse(productPrice);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(
          productName,
          style: getMediumStyle(color: ColorManager.primary)
              .copyWith(fontSize: 18.sp),
        )),
        Text(
          price != null ? formatter.format(price) : '0',
          style: getMediumStyle(color: ColorManager.primary)
              .copyWith(fontSize: 18.sp),
        ),
      ],
    );
  }
}
