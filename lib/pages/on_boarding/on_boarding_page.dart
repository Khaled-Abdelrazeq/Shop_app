import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/on_boarding/on_board_model.dart';
import 'package:shop_app/pages/home/home_page/home_page.dart';
import 'package:shop_app/pages/login/login_page.dart';
import 'package:shop_app/network/local/player_pref.dart';
import 'package:shop_app/pages/on_boarding/on_boarding_view_model.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/contsts/onboarding_consts.dart';

import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubit/states/app_states.dart';

class OnBoardingPage extends StatelessWidget {
  OnBoardingPage({Key? key}) : super(key: key);

  OnBoardingViewModel boarding = OnBoardingViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
            appBar: AppBar(),
            body: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      reverse: isAppArabic ? true : false,
                      controller: boarding.pageController,
                      onPageChanged: (index) {
                        boarding.changeBoardingPage(index, context);
                      },
                      physics: const BouncingScrollPhysics(),
                      itemCount: boarding.boards.length,
                      itemBuilder: (context, index) {
                        return OnBoardItem(item: boarding.boards[index]);
                      }),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    boardRadio(index: isAppArabic ? 3 : 0),
                    boardRadio(index: isAppArabic ? 2 : 1),
                    boardRadio(index: isAppArabic ? 1 : 2),
                    boardRadio(index: isAppArabic ? 0 : 3),
                  ],
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      if (isAppArabic) finishButton(cubit, context),
                      if (isAppArabic) const Spacer(),
                      TextButton(
                          onPressed: () {
                            onBoardingFinish(cubit, context);
                          },
                          child: Text(
                            boarding.skip,
                            style: boarding.onBoardingTextStyle,
                          )),
                      if (!isAppArabic) const Spacer(),
                      if (!isAppArabic) finishButton(cubit, context)
                    ],
                  ),
                )
              ],
            ));
      },
    );
  }

  MaterialButton finishButton(AppCubit cubit, BuildContext context) {
    return MaterialButton(
      color: boarding.onBoardPrimaryColor,
      onPressed: () {
        if (currentPage < boarding.boards.length - 1) {
          boarding.pageController.nextPage(
              duration: const Duration(microseconds: 1800),
              curve: Curves.bounceInOut);
        } else {
          onBoardingFinish(cubit, context);
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isAppArabic)
            Icon(
              isAppArabic ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: Colors.white,
            ),
          Text(
              currentPage == boarding.boards.length - 1
                  ? boarding.finish
                  : boarding.next,
              style:
                  boarding.onBoardingTextStyle.copyWith(color: Colors.white)),
          if (!isAppArabic)
            Icon(
              isAppArabic ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  void onBoardingFinish(AppCubit cubit, BuildContext context) {
    currentBottomNavIndex = 0;
    print('$isLoggedIn     $token');

    PlayerPref.setData(key: 'isOnBoard', value: true).then((value) => cubit
        .moveAndFinish(context, token.isNotEmpty ? HomePage() : LoginPage()));
  }
}

class OnBoardItem extends StatelessWidget {
  final OnBoardItemDetails item;

  OnBoardItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  OnBoardingViewModel boarding = OnBoardingViewModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            item.imagePath,
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isAppArabic) title_2(),
              if (isAppArabic) const SizedBox(width: 15),
              Text(
                item.title_1,
                style: boarding.onBoardTitleStyle,
              ),
              if (!isAppArabic) const SizedBox(width: 5),
              if (!isAppArabic) title_2(),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            item.details,
            textDirection: isAppArabic ? TextDirection.rtl : TextDirection.ltr,
            maxLines: 4,
            style:
                Theme.of(context).textTheme.headline6?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Text title_2() {
    return Text(
      item.title_2,
      style: boarding.onBoardTitleStyle.copyWith(color: Colors.blueAccent),
    );
  }
}
