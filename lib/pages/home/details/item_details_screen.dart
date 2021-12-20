import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shop_app/pages/home/details/details_view_model.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';

import '../product/product_producer.dart';

class ItemDetails extends StatelessWidget {
  final dynamic model;
  bool isFavorite = false;
  bool isHome = false;
  ItemDetails(
      {Key? key, this.model, required this.isFavorite, required this.isHome})
      : super(key: key);

  DetailsViewModel details = DetailsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(details.title),
        ),
        body: SingleChildScrollView(
            child: buildDetailsItem(context, model, isFavorite, isHome)));
  }
}

Widget buildDetailsItem(
    context, dynamic product, bool isFavorite, bool isHome) {
  DetailsViewModel details = DetailsViewModel();
  List<String> imagesUrl = [product?.image];
  if (!isFavorite) {
    product?.images.forEach((imageUrl) {
      imagesUrl.add(imageUrl);
    });
  }
  return Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: imagesUrl.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(width: 10);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      child: cashedImage(imgURL: imagesUrl[index]));
                },
              ),
            ),
          ),
          isAppArabic
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (isFavorite || isHome)
                      if (product?.discount != 0)
                        details.multiText(
                            context: context,
                            text1: '',
                            text2: '\$${product?.oldPrice.round()}'),
                    const Spacer(),
                    details.multiText(
                        context: context,
                        text1: details.price,
                        text2: '\$${product?.price.round()}'),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    details.multiText(
                        context: context,
                        text1: details.price,
                        text2: '\$${product?.price.round()}'),
                    const Spacer(),
                    if (isFavorite || isHome)
                      if (product?.discount != 0)
                        details.multiText(
                            context: context,
                            text1: '',
                            text2: '\$${product?.oldPrice.round()}'),
                  ],
                ),
          if (isFavorite || isHome)
            if (product?.discount != 0) details.spacer(),
          if (isFavorite || isHome)
            if (product?.discount != 0)
              details.multiText(
                  context: context,
                  text1: details.discount,
                  text2: '%${product?.discount}'),
          details.spacer(),
          details.multiText(
              context: context, text1: details.name, text2: '${product?.name}'),
          details.spacer(),
          details.multiText(
              context: context,
              text1: details.description,
              text2: '${product?.description}'),
          const SizedBox(height: 5),
        ],
      ),
    ),
  );
}
