import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/pages/home/favorite/favorite_model.dart';
import 'package:shop_app/pages/home/favorite/favourite_producer.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';

import '../product/product_producer.dart';

class FavoriteViewModel {
  FavoriteProducer producer = FavoriteProducer();

  static FavoriteModel? favoriteChangeStatusModel;
  static FavoriteModel? favoriteModel;

  void changeFavoriteState(context, productId) {
    producer.changeFavoriteItemStatus(
        context, productId, isAppArabic ? 'ar' : 'en');
  }

  void getAllFavoriteData(context) {
    producer.getFavoriteModel(context, isAppArabic ? 'ar' : 'en');
  }

  Widget favoriteItem(BuildContext context,
      FavoriteProductModel? model) //, FavoriteModel? model)
  {
    return itemPreview(context, model, isFavoriteScreen: true);
  }
}
