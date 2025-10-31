import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/resources/styles_manager.dart';
import 'package:e_commerce_app/features/main/categories/presentation/Bloc/categories_bloc.dart';
import 'package:e_commerce_app/features/main/categories/presentation/widgets/category_card_item.dart';
import 'package:e_commerce_app/features/main/home/presentation/Bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import 'sub_category_item.dart';

class SubCategoriesList extends StatelessWidget {
  const SubCategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        AppConstants.loadingDialog(context, state.getSubCategoriesState==HomeRequestState.loading);
      },
      builder: (context, state) {
        return Expanded(
          flex: 2,
          child: CustomScrollView(
            slivers: <Widget>[
              // category title
              SliverToBoxAdapter(
                child: Text(
                  state.model?.data?[state.selectedIndex].name??"",
                  style: getBoldStyle(
                      color: ColorManager.primary, fontSize: 14),
                ),
              ),
              // the category card
              SliverToBoxAdapter(
                child: CategoryCardItem(
                    state.model?.data?[state.selectedIndex].name??"",
                    state.model?.data?[state.selectedIndex].image??"",
                    goToCategoryProductsListScreen),
              ),
              // the grid view of the subcategories
              SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.subModel?.data?.length??0,
                        (context, index) =>
                        SubCategoryItem(
                            state.subModel?.data?[index].name??"",
                            state.model?.data?[state.selectedIndex].id??"",
                            Assets.images.subCategoryCardImage.path,
                            goToCategoryProductsListScreen),
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,))
            ],
          ),
        );
      },
    );
  }

  goToCategoryProductsListScreen() {
    // todo implement this function
  }
}
