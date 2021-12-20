import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/home/settings_and_profile/profile_view_model.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

import 'login_model.dart';

class ProfileProducer {
  void getUserData(context, lang) {
    ShopCubit.get(context).changeState(ShopGetUserDataLoadingState());
    DioHandler.getData(url: profileEndPoint, lang: lang, auth: token)
        .then((value) {
      ProfileViewModel.userData = LoginModel.fromJson(value.data);
      ShopCubit.get(context).changeState(
          ShopGetUserDataSuccessState(ProfileViewModel.userData?.data));
    }).catchError((e) {
      print('Error when getting user data $e');
      ShopCubit.get(context).changeState(ShopGetUserDataFailedState());
    });
  }

  void changeState(context, state) {
    ShopCubit.get(context).changeState(state);
  }
}
