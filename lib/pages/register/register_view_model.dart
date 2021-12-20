import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/pages/home/settings_and_profile/login_model.dart';
import 'package:shop_app/pages/register/register_producer.dart';
import 'package:shop_app/shared/contsts/constants.dart';

class RegisterViewModel {
  RegisterProducer producer = RegisterProducer();

  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String registerTitle;
  late String nameValidation;
  late String emailValidation;
  late String passwordValidation;
  late String repeatPasswordValidation;
  late String repeatPasswordValidation2;
  late String phoneValidation;
  late String email;
  late String phone;
  late String password;
  late String confirmPassword;
  late String username;

  late String registerButton;
  late String alreadyHaveAccount;
  late String loginBtn;

  RegisterViewModel() {
    registerTitle = '${lang.registerMap['registerTitle']}';
    emailValidation = '${lang.registerMap['emailValidation']}';
    passwordValidation = '${lang.registerMap['passwordValidation']}';
    nameValidation = '${lang.registerMap['nameValidation']}';
    repeatPasswordValidation =
        '${lang.registerMap['repeatPasswordValidation']}';
    repeatPasswordValidation2 =
        '${lang.registerMap['repeatPasswordValidation2']}';
    phoneValidation = '${lang.registerMap['phoneValidation']}';
    email = '${lang.registerMap['email']}';
    password = '${lang.registerMap['password']}';
    confirmPassword = '${lang.registerMap['confirmPassword']}';
    username = '${lang.registerMap['username']}';
    phone = '${lang.registerMap['phone']}';
    registerButton = '${lang.registerMap['registerButton']}';
    alreadyHaveAccount = '${lang.registerMap['alreadyHaveAccount']}';
    loginBtn = '${lang.registerMap['loginBtn']}';
  }

  static late LoginModel registerModel;

  void registerNewUser(
      {required context,
      required String username,
      required String email,
      required String password,
      required String phone}) {
    producer.postRegisterData(context, username, email, password, phone);
  }
}
