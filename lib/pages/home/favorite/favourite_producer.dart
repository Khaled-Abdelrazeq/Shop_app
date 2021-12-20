import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/home/favorite/favorite_model.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/pages/home/product/product_view_model.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

class FavoriteProducer {
  void changeFavoriteItemStatus(context, int productId, lang) {
    // Change fav status when clicked
    ProductViewModel.favoriteList[productId] =
        !(ProductViewModel.favoriteList[productId] ?? false);
    ShopCubit.get(context).changeState(ShopChangeFavoriteSuccessState());

    DioHandler.postData(path: favouriteEndPoint, auth: token, data: {
      'product_id': productId,
    }).then((value) {
      FavoriteViewModel.favoriteChangeStatusModel =
          FavoriteModel.fromJsonStatus(value.data);
      // print(FavoriteViewModel.favoriteChangeStatusModel?.message);

      // Change fav status when fail
      if (!(FavoriteViewModel.favoriteChangeStatusModel?.status ?? false)) {
        ProductViewModel.favoriteList[productId] =
            !(ProductViewModel.favoriteList[productId] ?? false);
        addToast(
            msg: FavoriteViewModel.favoriteChangeStatusModel?.message ?? '',
            type: ToastType.error);
      } else {
        getFavoriteModel(context, lang);
      }

      ShopCubit.get(context).changeState(ShopChangeFavoriteSuccessState());
    }).catchError((e) {
      // Change fav status when fail
      ProductViewModel.favoriteList[productId] =
          !(ProductViewModel.favoriteList[productId] ?? false);

      addToast(
          msg: FavoriteViewModel.favoriteChangeStatusModel?.message ?? '',
          type: ToastType.error);
      print('Error when changing Favorite status $e');
      ShopCubit.get(context).changeState(ShopChangeFavoriteFailedState());
    });
  }

  void getFavoriteModel(context, lang) {
    ShopCubit.get(context).changeState(ShopFavoriteLoadingState());
    DioHandler.getData(url: favouriteEndPoint, lang: lang, auth: token)
        .then((value) {
      FavoriteViewModel.favoriteModel = FavoriteModel.fromJson(value.data);
      print(FavoriteViewModel.favoriteModel?.dataModel?.data2[0].product?.name);
      ShopCubit.get(context).changeState(ShopGetFavoriteSuccessState());
    }).catchError((e) {
      print("Error when getting favorite data $e");
      ShopCubit.get(context).changeState(ShopGetFavoriteFailedState());

      //Failed
      addToast(msg: 'Failed To Connection', type: ToastType.error);
      getFavoriteModel(context, lang);
    });
  }
}
