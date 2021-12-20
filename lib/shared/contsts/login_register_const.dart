import 'package:flutter/material.dart';
import 'package:shop_app/network/local/player_pref.dart';
import 'package:shop_app/pages/login/login_page.dart';
import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';

bool isLoggedIn = false;
String token = '';

bool obscureTextLogin = true;
TextEditingController emailControllerLogin = TextEditingController();
TextEditingController passwordControllerLogin = TextEditingController();

TextEditingController passwordController = TextEditingController();

bool obscurePasswordRegister = true;
bool obscurePasswordRepeatRegister = true;

void logOut(context, AppCubit cubit) {
  PlayerPref.removeData(key: 'token')
      .then((value) => cubit.moveAndFinish(context, LoginPage()));
}
