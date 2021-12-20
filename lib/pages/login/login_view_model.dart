import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/network/local/player_pref.dart';
import 'package:shop_app/pages/home/settings_and_profile/login_model.dart';
import 'package:shop_app/pages/login/login_producer.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';

class LoginViewModel {
  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String loginTextTitle;
  late String emailValidation;
  late String passwordValidation;

  late String buttonTextLogin;
  late String donotHaveAccount;
  late String signUpText;
  late String forgetPassword;
  late String email;
  late String password;

  LoginViewModel() {
    loginTextTitle = '${lang.loginMap['loginTextTitle']}';
    emailValidation = '${lang.loginMap['emailValidation']}';
    passwordValidation = '${lang.loginMap['passwordValidation']}';
    buttonTextLogin = '${lang.loginMap['buttonTextLogin']}';
    donotHaveAccount = '${lang.loginMap['donotHaveAccount']}';
    signUpText = '${lang.loginMap['signUpText']}';
    forgetPassword = '${lang.loginMap['forgetPassword']}';
    email = '${lang.loginMap['email']}';
    password = '${lang.loginMap['password']}';
  }

  LoginProducer producer = LoginProducer();
  static late LoginModel loginMessageModel;

  void addSuccessMessage(String msg) {
    addToast(msg: msg, type: ToastType.success);
  }

  void addFailedMessage(String msg) {
    addToast(msg: msg, type: ToastType.error);
  }

  void onUserLogin(
      {required context, required String email, required String password}) {
    producer.onUserLogin(context, email, password);
  }
}
