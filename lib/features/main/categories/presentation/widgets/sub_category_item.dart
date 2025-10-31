import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:flutter/material.dart';

class SubCategoryItem extends StatelessWidget {
  final String title;
  final String image;
  final String categoryId;

  final Function navigation;

  const SubCategoryItem(this.title,this.categoryId, this.image, this.navigation, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushRoute(ProductsRoute(categoryId:categoryId));
      },
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorManager.primary, width: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
              /*  CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: image,
                  placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),

                ),*/
                Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: getRegularStyle(color: ColorManager.primary),
          )
        ],
      ),
    );
  }
}
