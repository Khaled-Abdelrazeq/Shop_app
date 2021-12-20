import 'package:shop_app/pages/home/settings_and_profile/login_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates {}

// Get Product Shop
class ShopHomeLoadingState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeFailedState extends ShopStates {}

// Get Categories Shop
class ShopCategoryLoadingState extends ShopStates {}

class ShopCategorySuccessState extends ShopStates {}

class ShopCategoryFailedState extends ShopStates {}

// -----------------------Home States ------------------------
class AppChangeNavState extends ShopStates {}

class ShopChangeFavoriteSuccessState extends ShopStates {}

class ShopChangeFavoriteFailedState extends ShopStates {}

//Get Favorites
class ShopFavoriteLoadingState extends ShopStates {}

class ShopGetFavoriteSuccessState extends ShopStates {}

class ShopGetFavoriteFailedState extends ShopStates {}

// Get User Data States
class ShopGetUserDataLoadingState extends ShopStates {}

class ShopGetUserDataSuccessState extends ShopStates {
  DataLoginMessage? userData;
  ShopGetUserDataSuccessState(this.userData);
}

class ShopGetUserDataFailedState extends ShopStates {}

class ShopUpdateProfileLoadingState extends ShopStates {}

class ShopUpdateProfileSuccessState extends ShopStates {
  LoginModel? model;
  ShopUpdateProfileSuccessState(this.model);
}

class ShopUpdateProfileFailedState extends ShopStates {}

class ShopSearchLoadingState extends ShopStates {}

class ShopChangeAppThemeState extends ShopStates {}

class ShopChangeAppLanguageState extends ShopStates {}
