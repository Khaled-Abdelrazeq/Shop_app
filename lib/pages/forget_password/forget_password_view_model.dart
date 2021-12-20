import 'package:flutter/cupertino.dart';
import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/pages/forget_password/forget_password_model.dart';
import 'package:shop_app/pages/forget_password/forget_password_producer.dart';
import 'package:shop_app/shared/contsts/constants.dart';

class ForgetPasswordViewModel {
  ForgetPasswordProducer producer = ForgetPasswordProducer();

  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String title;
  late String validationEmail;
  late String validationCode;
  late String validationPassword;
  late String emailText;
  late String getCode;
  late String gotoLogin;
  late String sendCodeAgain;
  late String resetPasswordText;
  late String newPasswordText;
  late String codeText;

  ForgetPasswordViewModel() {
    title = '${lang.forgetPasswordMap['title']}';
    validationEmail = '${lang.forgetPasswordMap['validationEmail']}';
    validationPassword = '${lang.forgetPasswordMap['validationPassword']}';
    validationCode = '${lang.forgetPasswordMap['validationCode']}';
    validationCode = '${lang.forgetPasswordMap['validationCode']}';
    emailText = '${lang.forgetPasswordMap['emailText']}';
    getCode = '${lang.forgetPasswordMap['getCode']}';
    gotoLogin = '${lang.forgetPasswordMap['gotoLogin']}';
    sendCodeAgain = '${lang.forgetPasswordMap['sendCodeAgain']}';
    resetPasswordText = '${lang.forgetPasswordMap['resetPassword']}';
    newPasswordText = '${lang.forgetPasswordMap['newPasswordText']}';
    codeText = '${lang.forgetPasswordMap['codeText']}';
  }

  String email = '';

  static bool codeSent = false;
  static bool verified = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  static ForgetPasswordModel? forgetPasswordModel;
  void sendCodeToUser({required context, required String email}) {
    producer.sendCodeToMail(context, email);
  }

  void resetPassword({required context, email, password, code}) {
    producer.resetPassword(context, email, code, password);
  }
}
