import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/pages/home/categories/categories_view_model.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/pages/home/product/product_view_model.dart';
import 'package:shop_app/pages/home/settings_and_profile/profile_producer.dart';
import 'package:shop_app/pages/home/settings_and_profile/update_profile_producer.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

import 'login_model.dart';

class ProfileViewModel {
  ProfileProducer getProfileProducer = ProfileProducer();
  UpdateProfileProducer updateProfileProducer = UpdateProfileProducer();
  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String update;
  late String logOut;
  late String instruction;
  late String themeApp;
  late String languageApp;
  late String username;
  late String email;
  late String phone;
  late String emailValidation;
  late String phoneValidation;
  late String nameValidation;

  ProfileViewModel() {
    update = '${lang.settingsMap['update']}';
    instruction = '${lang.settingsMap['instruction']}';
    themeApp = isAppDark
        ? '${lang.settingsMap['dark']}'
        : '${lang.settingsMap['light']}';
    languageApp = '${lang.settingsMap['lang']}';
    logOut = '${lang.settingsMap['logout']}';
    username = '${lang.settingsMap['username']}';
    email = '${lang.settingsMap['email']}';
    phone = '${lang.settingsMap['phone']}';
    emailValidation = '${lang.settingsMap['emailValidation']}';
    phoneValidation = '${lang.settingsMap['phoneValidation']}';
    nameValidation = '${lang.settingsMap['nameValidation']}';
  }

  static LoginModel? userData;
  static LoginModel? updateProfileModel;

  void getUserData(context) {
    getProfileProducer.getUserData(context, isAppArabic ? 'ar' : 'en');
  }

  void updateProfile(
      {required context,
      required String email,
      required String name,
      required String phone}) {
    updateProfileProducer.updateProfile(context, email, name, phone);
  }

  void changeThemeState(context) {
    getProfileProducer.changeState(context, ShopChangeAppThemeState());
  }

  void changeLanguageState(context) {
    getProfileProducer.changeState(context, ShopChangeAppLanguageState());
  }
}
