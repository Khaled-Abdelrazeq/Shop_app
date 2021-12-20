import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/home/details/item_details_screen.dart';
import 'package:shop_app/pages/home/product/product_view_model.dart';
import 'package:shop_app/pages/home/product/home_model.dart';
import 'package:shop_app/pages/home/categories/categories_model.dart';
import 'package:shop_app/pages/home/categories/categories_view_model.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  ProductViewModel product = ProductViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: ProductViewModel.homeModel != null,
          fallback: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
          builder: (BuildContext context) {
            return productBuilder(ProductViewModel.homeModel!, context);
          },
        );
      },
    );
  }

  Widget productBuilder(HomeModelJson homeModel, context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          //CategoryTitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              product.categories,
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 25),
            ),
          ),
          //Categories
          Container(
            padding: const EdgeInsets.all(10),
            height: 150,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return categoryItems(
                      context,
                      CategoriesViewModel
                          .categoriesModel?.dataModel?.detailsData[index]);
                },
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemCount: CategoriesViewModel
                        .categoriesModel?.dataModel?.detailsData.length ??
                    0),
          ),
          //Carousel Slider
          CarouselSlider(
            items: homeModel.dataModel?.banners
                .map(
                    (e) => cashedImage(imgURL: '${e.image}', fit: BoxFit.cover))
                .toList(),
            options: CarouselOptions(
              height: 250,
              initialPage: 0,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Text(
              product.mostSales,
              style:
                  Theme.of(context).textTheme.headline6?.copyWith(fontSize: 25),
            ),
          ),
          Column(
            children: [
              GridView.count(
                  crossAxisCount: 2,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  semanticChildCount: 1,
                  childAspectRatio: 1 / 1.7,
                  children: List.generate(
                    homeModel.dataModel?.products.length ?? 0,
                    (index) => buildGridProductItem(
                        context, homeModel.dataModel?.products[index]),
                  )),
              Container(
                height: 100,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildGridProductItem(context, HomeModelDataProducts? product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemDetails(
                      model: product,
                      isHome: true,
                      isFavorite: false,
                    )));
      },
      child: Stack(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: cashedImage(
                            imgURL: product?.image ?? imageNotFoundURL)),
                  ),
                  Row(
                    children: [
                      Text(
                        '\$${product?.price.round()}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 15),
                      ),
                      const SizedBox(width: 10),
                      if (product?.discount != 0)
                        Text(
                          '\$${product?.oldPrice.round()}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough),
                        ),
                    ],
                  ),
                  Text(
                    product?.name ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        height: 1.1,
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // UI
          Row(
            children: [
              if (product?.discount != 0)
                Container(
                  width: 60,
                  height: 45,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      color: discountColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      )),
                  child: Center(
                    child: Text(
                      '-${product?.discount}%',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              const Spacer(),
              IconButton(
                icon: ProductViewModel.favoriteList[product?.id] ?? false
                    ? Icon(
                        Icons.favorite,
                        size: 30,
                        color: cardColor,
                      )
                    : const Icon(
                        Icons.favorite_border,
                        size: 30,
                      ),
                onPressed: () {
                  print(ProductViewModel.favoriteList[product?.id]);
                  FavoriteViewModel favoriteModel = FavoriteViewModel();
                  favoriteModel.changeFavoriteState(context, product?.id);
                },
              ),
            ],
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              width: 35,
              height: 30,
              decoration: BoxDecoration(
                color: countColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(10)),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget categoryItems(BuildContext context, CategoriesDataDetailsModel? model) {
  return Container(
    width: 150,
    height: 150,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(25),
            //     image:
            //     DecorationImage(
            //       image: NetworkImage(model?.image ?? imageNotFoundURL),
            //     )            ),
            child: cashedImage(imgURL: model?.image ?? imageNotFoundURL)),

        // cashedImage(imgURL: model?.image ?? imageNotFoundURL),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.black26,
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 30,
            child: Center(
              child: Text(
                model?.name ?? '',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    ),
  );
}
