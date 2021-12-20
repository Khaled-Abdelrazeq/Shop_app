import 'package:shop_app/pages/home/product/product_view_model.dart';
import 'package:shop_app/pages/home/product/home_model.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/local/player_pref.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

class ProductProducer {
  void getHomeData(context, String lang) {
    ShopCubit.get(context).changeState(ShopHomeLoadingState());
    DioHandler.getData(
            url: homeEndPoint,
            lang: lang,
            auth: PlayerPref.getData(key: 'token'))
        .then((value) {
      ProductViewModel.homeModel = HomeModelJson(value.data);

      ProductViewModel.homeModel?.dataModel?.products
          .forEach((element) => ProductViewModel.favoriteList.addAll({
                element.id!: element.isInFavorite!,
              }));

      ShopCubit.get(context).changeState(ShopHomeSuccessState());
    }).catchError((e) {
      print(e.toString());
      ShopCubit.get(context).changeState(ShopHomeFailedState());

      //Failed
      addToast(msg: 'Failed To Connection', type: ToastType.error);
      getHomeData(context, lang);
    });
  }
}
