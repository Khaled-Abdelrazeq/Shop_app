import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/pages/home/search/search_model.dart';
import 'package:shop_app/pages/home/search/search_producer.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/constants.dart';

class SearchViewModel {
  SearchProducer producer = SearchProducer();

  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String title;

  SearchViewModel() {
    title = '${lang.searchMap['title']}';
  }

  TextEditingController searchController = TextEditingController();

  static SearchModel? searchModel;

  void getSearchItems({required context, required searchValue}) {
    producer.getItems(context, searchValue);
  }

  Widget searchItem(BuildContext context,
      FavoriteDataDataModel? model) //, FavoriteModel? model)
  {
    return itemPreview(context, model);
  }
}
