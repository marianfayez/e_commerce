
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final int index;
  final String title;

  final bool isSelected;
  final Function onItemClick;

  const CategoryItem(this.index, this.title, this.isSelected, this.onItemClick,
      {super.key});

  @override
  Widget build(BuildContext context) {
    // Handle item click by calling onItemClick callback
    return InkWell(
      onTap: () => onItemClick(index,context),
      child: Container(
        // Set background color based on selection
        color: isSelected?ColorManager.white:Colors.transparent,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            //Show/hide the indicator based on selection
            Visibility(
              visible: isSelected,
              child: Container(
                width: 8,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorManager.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            // wrap the text with expanded to avoid overflow error
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 16, horizontal: 8),
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: getMediumStyle(
                    color: ColorManager.primary, fontSize: 14),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
