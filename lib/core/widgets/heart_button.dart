import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class HeartButton extends StatefulWidget {
  final void Function()? onTap;
  final bool isFavorite;

  const HeartButton({
    super.key,
    required this.onTap,
    this.isFavorite = false,
  });

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  String heartIcon = Assets.icons.heart.path;
  late bool isClicked;

  @override
  void initState() {
    super.initState();
    isClicked = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // radius: 25,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      onTap: () {
        setState(() {
          isClicked = !isClicked;

          widget.onTap?.call();
        });
      },
      child: Material(
        // borderRadius: BorderRadius.circular(2),
        color: ColorManager.white,
        elevation: 5,
        shape: const StadiumBorder(),
        shadowColor: ColorManager.black,
        child: Padding(
            padding: const EdgeInsets.all(6),
            child: ImageIcon(
              AssetImage(
                isClicked
                    ? Assets.icons.clickedHeart.path
                    : Assets.icons.heart.path,
              ),
              color: ColorManager.primary,
            )),
      ),
    );
  }
}
