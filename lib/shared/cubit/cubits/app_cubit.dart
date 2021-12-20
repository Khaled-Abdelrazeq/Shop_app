import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/home/categories/categories_view_model.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/pages/home/product/product_view_model.dart';
import 'package:shop_app/pages/home/settings_and_profile/profile_view_model.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/contsts/onboarding_consts.dart';
import 'package:shop_app/shared/cubit/states/app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  void moveAndFinish(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
    emit(AppMoveToNextPageState());
  }

  void moveToHome(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget));
    emit(AppMoveToHomePageState());
  }

  void changeObscureTextLogin({required bool check}) {
    obscureTextLogin = check;
    emit(AppChangeObscureTextLoginState());
  }

  void changeState(AppStates state) {
    emit(state);
  }

  void getUserData(context) {
    //Get User Data
    ProductViewModel home = ProductViewModel();
    home.getHomeData(context);

    CategoriesViewModel category = CategoriesViewModel();
    category.getCategoriesShop(context);

    FavoriteViewModel favorite = FavoriteViewModel();
    favorite.getAllFavoriteData(context);

    ProfileViewModel profile = ProfileViewModel();
    profile.getUserData(context);

    emit(AppGetUserDataState());
  }
}
