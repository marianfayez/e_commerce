import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/main/categories/presentation/Bloc/categories_bloc.dart';
import 'package:e_commerce_app/features/main/categories/presentation/widgets/categories_list.dart';
import 'package:e_commerce_app/features/main/categories/presentation/widgets/sub_categories_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesTab extends StatefulWidget {
  const CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesBloc>()..add(GetCategoriesEvent()),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 12, vertical: 12),
        child: Row(
          children: [
            CategoriesList(),
            SizedBox(
              width: 16,
            ),
            SubCategoriesList()
          ],
        ),
      ),
    );
  }
}
