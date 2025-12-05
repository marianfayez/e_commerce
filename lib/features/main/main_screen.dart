import 'package:auto_route/annotations.dart';
import 'package:e_commerce_app/core/resources/assets.gen.dart';
import 'package:e_commerce_app/core/resources/color_manager.dart';
import 'package:e_commerce_app/core/widgets/SharedSearchScaffold.dart';
import 'package:e_commerce_app/di.dart';
import 'package:e_commerce_app/features/main/categories/presentation/Screen/categories_tab.dart';
import 'package:e_commerce_app/features/main/favorites/presentation/Screen/favorites_tab.dart';
import 'package:e_commerce_app/features/main/home/presentation/Bloc/home_bloc.dart';
import 'package:e_commerce_app/features/main/home/presentation/Screen/home_tab.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Bloc/profile_bloc.dart';
import 'package:e_commerce_app/features/main/profile/presentation/Screen/profile_tab.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_bloc.dart';
import 'package:e_commerce_app/features/product_screen/presentation/bloc/product_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  List<Widget> tabs = [
    const HomeTab(),
    const CategoriesTab(),
    const FavoriteTab(),
    const ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<HomeBloc>()..add(CategoriesEvent())),
        BlocProvider(create: (_) => getIt<ProfileBloc>()..add(GetData())..add(GetAddresses())),
      ],
      child: Scaffold(
        extendBody: false,
        body: SharedSearchScaffold(
          child: tabs[currentIndex],
        ),

        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (value) => changeSelectedIndex(value),
            backgroundColor: ColorManager.primary,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: ColorManager.primary,
            unselectedItemColor: ColorManager.white,
            showSelectedLabels: true,
            // Hide selected item labels
            showUnselectedLabels: true,
            // Hide unselected item labels
            items: [
              // Build BottomNavigationBarItem widgets for each tab
              CustomBottomNavBarItem(Assets.icons.icHome.path, "Home"),
              CustomBottomNavBarItem(Assets.icons.icCategory.path, "Category"),
              CustomBottomNavBarItem(Assets.icons.icWishList.path, "WishList"),
              CustomBottomNavBarItem(Assets.icons.icProfile.path, "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  changeSelectedIndex(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
      context.read<ProductScreenBloc>().add(ClearSearchEvent());

    });
  }
}

class CustomBottomNavBarItem extends BottomNavigationBarItem {
  String iconPath;
  String title;

  CustomBottomNavBarItem(this.iconPath, this.title)
      : super(
          label: title,
          icon: ImageIcon(
            AssetImage(iconPath), // Inactive icon image
            color: ColorManager.white, // Inactive icon color
          ),
          activeIcon: CircleAvatar(
            backgroundColor: ColorManager.white, // Background of active icon
            child: ImageIcon(
              AssetImage(iconPath),
              color: ColorManager
                  .primary, // Active icon imagecolor: ColorManager.primary, // Active icon color
            ),
          ),
        );
}

