import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/home/home_page/home_page.dart';
import 'package:shop_app/pages/login/login_page.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/on_boarding/on_boarding_view_model.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/contsts/onboarding_consts.dart';

import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';
import 'package:shop_app/shared/thems.dart';
import 'pages/on_boarding/on_boarding_page.dart';
import 'network/local/player_pref.dart';

void main() async {
  // To make sure await functions worked well and then runApp
  WidgetsFlutterBinding.ensureInitialized();

  DioHandler.init();
  await PlayerPref.init();

  isAppDark = PlayerPref.getData(key: 'isAppDark') ?? false;
  isAppArabic = PlayerPref.getData(key: 'isAppArabic') ?? false;
  isOnBoard = PlayerPref.getData(key: 'isOnBoard') ?? false;
  isLoggedIn = PlayerPref.getData(key: 'token') != null ? true : false;
  token = PlayerPref.getData(key: 'token') ?? '';

  print(token);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => ShopCubit()),
        BlocProvider(create: (BuildContext context) => AppCubit()),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          if (state is ShopInitState) {
            AppCubit.get(context).getUserData(context);
          }
          print('Main: $state');
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: isAppDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: Directionality(
                textDirection:
                    isAppArabic ? TextDirection.rtl : TextDirection.ltr,
                child: isOnBoard
                    ? isLoggedIn
                        ? HomePage()
                        : LoginPage()
                    : OnBoardingPage()),
          );
        },
      ),
    );
  }
}
