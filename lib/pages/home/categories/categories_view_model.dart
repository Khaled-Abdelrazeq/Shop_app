import 'package:flutter/material.dart';
import 'package:shop_app/pages/home/categories/categories_model.dart';
import 'package:shop_app/pages/home/categories/category_producer.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';

class CategoriesViewModel {
  CategoryProducer producer = CategoryProducer();

  static CategoriesModel? categoriesModel;

  void getCategoriesShop(context) {
    producer.getCategoriesShop(context, isAppArabic ? 'ar' : 'en');
  }

  Widget categoryItem(BuildContext context, CategoriesDataDetailsModel? model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: cashedImage(
                      imgURL: model?.image ?? imageNotFoundURL,
                      fit: BoxFit.cover),
                ),
                const SizedBox(width: 20),
                Text(
                  model?.name ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
