import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/pages/home/details/item_details_screen.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/pages/home/product/product_view_model.dart';
import 'package:shop_app/pages/home/search/search_view_model.dart';
import 'package:shop_app/pages/on_boarding/on_boarding_view_model.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'colors.dart';
import 'contsts/home_conts.dart';
import 'contsts/login_register_const.dart';
import 'contsts/onboarding_consts.dart';

Radio<int> boardRadio({required int index}) {
  return Radio(
      activeColor: cardColor,
      value: index,
      groupValue: currentPage,
      onChanged: (value) {});
}
//---------------------------------------------------

Widget textField({
  required context,
  required TextEditingController controller,
  Function? onSubmittedFunction,
  required String labelText,
  required IconData prefixIcon,
  required String validateText,
  bool isEnabled = true,
  TextInputType keyboardType = TextInputType.text,
  double radius = 10,
  bool obscureText = false,
  IconData? suffixIcon,
  Function? suffixFunction,
  bool isValidationEmail = false,
  bool isValidationConfirmPass = false,
  String? validateConfirmPass,
}) =>
    TextFormField(
      controller: controller,
      enabled: isEnabled,
      keyboardType: keyboardType,
      onFieldSubmitted: (_) {
        onSubmittedFunction!();
      },
      obscureText: obscureText,
      style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15),
          prefixIcon: Icon(
            prefixIcon,
            color: isAppDark ? Colors.grey : Colors.black,
          ),
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: () {
                    suffixFunction!();
                  },
                  icon: Icon(
                    suffixIcon,
                    color: isAppDark ? Colors.grey : Colors.black,
                  ))
              : const Text(''),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)))),
      validator: (value) {
        if (isValidationEmail) {
          if (value != null && value.isNotEmpty) {
            return null;
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value!)) {
            return isAppArabic
                ? 'من فضلك أدخل بريد إلكتروني صالح'
                : 'Please a valid Email';
          }
          return validateText;
        }

        if (isValidationConfirmPass) {
          if (value != passwordController.text) {
            return validateConfirmPass;
          }
          if (value != null && value.isNotEmpty) {
            return null;
          }
          return validateText;
        }

        if (value != null && value.isNotEmpty) {
          return null;
        }
        return validateText;
      },
    );

Widget buttonField({required String text, required Function function}) =>
    MaterialButton(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {
        function();
      },
      height: 50,
      minWidth: double.infinity,
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
      ),
      color: isAppDark ? buttonDark : buttonLight,
    );

Widget cashedImage({required String imgURL, BoxFit fit = BoxFit.scaleDown}) {
  return CachedNetworkImage(
    imageUrl: imgURL,
    fit: fit,
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) =>
        const Center(child: Icon(Icons.error)),
  );
}

Widget animSearch(
    {required context,
    required controller,
    required Function? function,
    required int widthSpace}) {
  SearchViewModel search = SearchViewModel();
  return AnimSearchBar(
    textController: controller,
    color: Colors.white,
    helpText: search.title,
    suffixIcon: const Icon(Icons.search),
    onSuffixTap: () {
      function!();
    },
    width: MediaQuery.of(context).size.width - widthSpace,
  );
}

Widget itemPreview(BuildContext context, dynamic? model,
    {bool isFavoriteScreen = false}) //, FavoriteModel? model)
{
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetails(
                    model: model,
                    isFavorite: isFavoriteScreen,
                    isHome: false,
                  )));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: cashedImage(imgURL: model?.image ?? imageNotFoundURL),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(25),
                //   image: DecorationImage(
                //       image: NetworkImage(model?.image ?? imageNotFoundURL)),
                // )
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model?.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 16)),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          '${model?.price.round()}',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 15),
                        ),
                        const SizedBox(width: 15),
                        if (isFavoriteScreen)
                          if (model?.discount != 0)
                            Text(
                              '${model?.oldPrice.round()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      fontSize: 13,
                                      decoration: TextDecoration.lineThrough),
                            ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              FavoriteViewModel favoriteModel =
                                  FavoriteViewModel();
                              favoriteModel.changeFavoriteState(
                                  context, model?.id);

                              // favoriteModel
                            },
                            icon: ProductViewModel.favoriteList[model?.id] ??
                                    false
                                ? Icon(
                                    Icons.favorite,
                                    color: cardColor,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                  )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
