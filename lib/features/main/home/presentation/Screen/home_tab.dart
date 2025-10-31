import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:e_commerce_app/core/routes/auto_route.gr.dart';
import 'package:e_commerce_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:e_commerce_app/features/main/home/presentation/Bloc/home_bloc.dart';
import 'package:e_commerce_app/features/main/home/presentation/widgets/custom_ads_widget.dart';
import 'package:e_commerce_app/features/main/home/presentation/widgets/custom_category_widget.dart';
import 'package:e_commerce_app/features/main/home/presentation/widgets/custom_section_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> adsImages = [
    Assets.images.carouselSlider1.path,
    Assets.images.carouselSlider2.path,
    Assets.images.carouselSlider3.path,
  ];

  @override
  void initState() {
    super.initState();
    _startImageSwitching();
  }

  void _startImageSwitching() {
    _timer = Timer.periodic(const Duration(milliseconds: 2500), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % adsImages.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return LoaderOverlay(
      useDefaultLoading: true,
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          AppConstants.loadingDialog(context, state.homeRequestState==HomeRequestState.loading);
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomAdsWidget(
                    adsImages: adsImages,
                    currentIndex: _currentIndex,
                    timer: _timer),
                Column(
                  children: [
                    CustomSectionBar(sectionNname: 'Categories', function: () {}),
                    SizedBox(
                      height: 270.h,
                      child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return
                            InkWell(
                              onTap: (){
                                context.pushRoute(ProductsRoute(categoryId:state.categoriesModel?.data?[index].id??""));
                              },
                              child: CustomCategoryWidget(
                              title: state.categoriesModel?.data?[index].name??"",
                              image: state.categoriesModel?.data?[index].image??"",
                                                        ),
                            );
                        },
                        itemCount: state.categoriesModel?.results??0,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
