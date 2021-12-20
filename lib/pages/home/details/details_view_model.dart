import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/contsts/constants.dart';

class DetailsViewModel {
  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String title;
  late String price;
  late String name;
  late String description;
  late String discount;

  DetailsViewModel() {
    title = '${lang.detailsMap['title']}';
    price = '${lang.detailsMap['price']}';
    name = '${lang.detailsMap['name']}';
    description = '${lang.detailsMap['description']}';
    discount = '${lang.detailsMap['discount']}';
  }

  Widget multiText(
      {required context, required String text1, required String text2}) {
    return RichText(
        textDirection: isAppArabic ? TextDirection.rtl : TextDirection.ltr,
        // textAlign: TextAlign.start,
        text: TextSpan(
            text: '$text1   ',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(fontSize: 18, color: cardColor),
            children: [
              TextSpan(
                  text: text2,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      ?.copyWith(fontSize: 17))
            ]));
  }

  Widget spacer() {
    return Column(
      children: [
        const SizedBox(height: 5),
        Container(height: 1, color: Colors.black26),
        const SizedBox(height: 5),
      ],
    );
  }
}
