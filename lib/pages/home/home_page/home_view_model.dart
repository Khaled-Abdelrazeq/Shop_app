import 'package:flutter/material.dart';
import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

import '../categories/category_screen.dart';
import '../favorite/favourite_screen.dart';
import '../product/product_screen.dart';
import '../settings_and_profile/settings_screen.dart';

class HomeViewModel {
  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String productsTitle;
  late String categoriesTitle;
  late String favouritesTitle;
  late String settingsTitle;
  late List<String> appBarTitle;

  HomeViewModel() {
    productsTitle = '${lang.homeMap['productsTitle']}';
    categoriesTitle = '${lang.homeMap['categoriesTitle']}';
    favouritesTitle = '${lang.homeMap['favouritesTitle']}';
    settingsTitle = '${lang.homeMap['settingsTitle']}';

    appBarTitle = [];
    appBarTitle.add(productsTitle);
    appBarTitle.add(categoriesTitle);
    appBarTitle.add(favouritesTitle);
    appBarTitle.add(settingsTitle);
  }

  List<Widget> bottomListItem = [
    ProductScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];
  changeBottomNav(context, index) {
    currentBottomNavIndex = index;
    ShopCubit.get(context).changeState(AppChangeNavState());
  }

  getBottomAppBar(context) {
    return BottomAppBar(
      color: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 7,
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  changeBottomNav(context, 0);
                },
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: currentBottomNavIndex == 0 ? Colors.blue : Colors.grey,
                ),
              ),
              IconButton(
                  onPressed: () {
                    changeBottomNav(context, 1);
                  },
                  icon: Icon(Icons.category_outlined,
                      size: 30,
                      color: currentBottomNavIndex == 1
                          ? Colors.blue
                          : Colors.grey)),
              const SizedBox(width: 15),
              IconButton(
                  onPressed: () {
                    changeBottomNav(context, 2);
                  },
                  icon: Icon(Icons.favorite,
                      size: 30,
                      color: currentBottomNavIndex == 2
                          ? Colors.blue
                          : Colors.grey)),
              IconButton(
                  onPressed: () {
                    changeBottomNav(context, 3);
                  },
                  icon: Icon(Icons.settings,
                      size: 30,
                      color: currentBottomNavIndex == 3
                          ? Colors.blue
                          : Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar getBottomNavBar(context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      onTap: (index) {
        changeBottomNav(context, index);
      },
      currentIndex: currentBottomNavIndex,
    );
  }
}
