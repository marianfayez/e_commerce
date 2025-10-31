import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/features/main/categories/presentation/Bloc/categories_bloc.dart';
import 'package:e_commerce_app/features/main/categories/presentation/widgets/category_item.dart';
import 'package:e_commerce_app/features/main/home/presentation/Bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  // Index of the currently selected category

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoriesBloc, CategoriesState>(
      listener: (context, state) {
        AppConstants.loadingDialog(context, state.getCategoriesState==HomeRequestState.loading);

      },
      builder: (context, state) {
        return Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.containerGray,
                border: Border(
                  // set the border for only 3 sides
                    top: BorderSide(
                        width: 2,
                        color: ColorManager.primary.withOpacity(0.3)),
                    left: BorderSide(
                        width: 2,
                        color: ColorManager.primary.withOpacity(0.3)),
                    bottom: BorderSide(
                        width: 2,
                        color: ColorManager.primary.withOpacity(0.3))),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),

              // the categories items list
              child: ClipRRect(
                // clip the corners of the container that hold the list view
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                child: ListView.builder(
                    itemCount: state.model?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return
                        CategoryItem(
                            index, state.model?.data?[index].name ?? "",
                            state.selectedIndex == index,
                            onItemClick);
                    }
                ),
              ),
            ));
      },
    );
  }

  // callback function to change the selected index
  onItemClick(int index, BuildContext context) {
    BlocProvider.of<CategoriesBloc>(context).add(
        ChangeSelectedIndexEvent(index));
  }
}
