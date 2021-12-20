import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/pages/home/product/home_model.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'product_producer.dart';

class ProductViewModel {
  ProductProducer producer = ProductProducer();
  static HomeModelJson? homeModel;
  static Map<int, bool> favoriteList = {};

  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String categories;
  late String mostSales;

  ProductViewModel() {
    categories = '${lang.productsMap['categories']}';
    mostSales = '${lang.productsMap['mostSales']}';
  }

  void getHomeData(context) {
    producer.getHomeData(context, isAppArabic ? 'ar' : 'en');
  }
}
