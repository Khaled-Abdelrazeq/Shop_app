import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

import 'categories_view_model.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  CategoriesViewModel category = CategoriesViewModel();

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: CategoriesViewModel.categoriesModel != null,
      fallback: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
      builder: (BuildContext context) {
        return BlocConsumer<ShopCubit, ShopStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return category.categoryItem(
                            context,
                            CategoriesViewModel.categoriesModel?.dataModel
                                ?.detailsData[index]);
                      },
                      separatorBuilder: (context, index) {
                        return Container(height: 1, color: Colors.grey);
                      },
                      itemCount: CategoriesViewModel
                              .categoriesModel?.dataModel?.detailsData.length ??
                          0),
                ),
                Container(
                  height: 55,
                )
              ],
            );
          },
        );
      },
    );
  }
}
