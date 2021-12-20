import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/home/categories/categories_view_model.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

import 'categories_model.dart';

class CategoryProducer {
  void getCategoriesShop(context, lang) {
    ShopCubit.get(context).changeState(ShopCategoryLoadingState());
    DioHandler.getData(url: categoriesEndPoint, lang: lang, auth: token)
        .then((value) {
      CategoriesViewModel.categoriesModel =
          CategoriesModel.fromJson(value.data);
      ShopCubit.get(context).changeState(ShopCategorySuccessState());
    }).catchError((e) {
      print('Error when getting Categories Shop');
      ShopCubit.get(context).changeState(ShopCategoryFailedState());

      //Failed
      addToast(msg: 'Failed To Connection', type: ToastType.error);
      getCategoriesShop(context, lang);
    });
  }
}
