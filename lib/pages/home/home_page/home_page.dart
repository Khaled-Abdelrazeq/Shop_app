import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/home/categories/categories_view_model.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/pages/home/product/product_view_model.dart';
import 'package:shop_app/pages/home/search/search_screen.dart';
import 'package:shop_app/pages/home/search/search_view_model.dart';
import 'package:shop_app/pages/home/settings_and_profile/profile_view_model.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

import 'home_view_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  HomeViewModel home = HomeViewModel();
  TextEditingController searchController = TextEditingController();

  ProductViewModel product = ProductViewModel();
  CategoriesViewModel category = CategoriesViewModel();
  FavoriteViewModel favorite = FavoriteViewModel();
  ProfileViewModel profile = ProfileViewModel();
  SearchViewModel search = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
              title: Text(home.appBarTitle[currentBottomNavIndex]),
              centerTitle: true,
              actions: [
                SizedBox(
                  width: 48,
                  child: IconButton(
                    icon: const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      switch (currentBottomNavIndex) {
                        case 0:
                          product.getHomeData(context);
                          break;
                        case 1:
                          category.getCategoriesShop(context);
                          break;
                        case 2:
                          favorite.getAllFavoriteData(context);
                          break;
                        case 3:
                          profile.getUserData(context);
                          break;
                      }
                    },
                  ),
                ),
                animSearch(
                    context: context,
                    widthSpace: 48,
                    controller: searchController,
                    function: () {
                      if (searchController.text.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen(
                                      searchValue: searchController.text,
                                    )));
                        ShopCubit.get(context)
                            .changeState(ShopSearchLoadingState());
                      }
                    })
              ]),
          // bottomNavigationBar: home.getBottomAppBar(context),
          // bottomNavigationBar: home.getBottomNavBar(context),
          // floatingActionButton: Stack(
          //   alignment: Alignment.topCenter,
          //   children: [
          //     FloatingActionButton(
          //       shape: BeveledRectangleBorder(
          //           borderRadius: BorderRadius.circular(10)),
          //       onPressed: () {},
          //       child:
          //           const Icon(Icons.shopping_bag_outlined, color: Colors.grey),
          //       backgroundColor: Colors.white,
          //       elevation: 7,
          //     ),
          //     Positioned(
          //       bottom: 40,
          //       child: Container(
          //         // width: 25,
          //         decoration: BoxDecoration(
          //             color: Colors.red,
          //             borderRadius: BorderRadius.circular(7)),
          //         child: const Text(
          //           '01',
          //           style: TextStyle(color: Colors.white, fontSize: 17),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.miniCenterDocked,
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    home.bottomListItem[currentBottomNavIndex],
                    Positioned(
                      bottom: 0,
                      width: MediaQuery.of(context).size.width,
                      child: home.getBottomAppBar(context),
                    ),
                    Positioned(
                      width: 60,
                      bottom: 30,
                      right: (MediaQuery.of(context).size.width / 2) - 30,
                      child: FloatingActionButton(
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onPressed: () {},
                        child: const Icon(Icons.shopping_bag_outlined,
                            color: Colors.grey),
                        backgroundColor: Colors.white,
                        elevation: 7,
                      ),
                    ),
                    Positioned(
                        bottom: 70,
                        right: MediaQuery.of(context).size.width / 2 - 15,
                        child: Container(
                            width: 30,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.redAccent,
                              color: cardColor,
                            ),
                            child: const Text(
                              '01',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
