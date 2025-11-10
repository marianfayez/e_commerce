import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/resources/font_manager.dart';

class ProfileInfoSection extends StatelessWidget {
  final String label;
  final String value;
  final bool isEditing;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType inputType;

  const ProfileInfoSection({
    super.key,
    required this.label,
    required this.value,
    required this.isEditing,
    required this.controller,
    required this.icon,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: ColorManager.primary.withOpacity(.3)),
      ),
      elevation: 0,
      margin: EdgeInsets.only(bottom: 16.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: ColorManager.primary),
            SizedBox(width: 12.w),
            Flexible(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isEditing
                    ? TextField(
                  key: const ValueKey("editable"),
                  controller: controller,
                  keyboardType: inputType,
                  style: getMediumStyle(
                    color: ColorManager.primary,
                    fontSize: FontSize.s16,
                  ),
                  decoration: InputDecoration(
                    labelText: label,
                    labelStyle: TextStyle(color: ColorManager.primary),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                )
                    : Column(
                  key: const ValueKey("readonly"),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: getRegularStyle(
                        color: ColorManager.primary.withOpacity(.6),
                        fontSize: FontSize.s14,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      value.isEmpty ? "Not set" : value,
                      style: getSemiBoldStyle(
                        color: ColorManager.primary,
                        fontSize: FontSize.s16,
                      ),
                    ),
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
