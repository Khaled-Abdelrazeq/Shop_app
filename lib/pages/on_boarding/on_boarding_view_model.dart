import 'package:flutter/cupertino.dart';
import 'package:shop_app/language/arabic.dart';
import 'package:shop_app/language/english.dart';
import 'package:shop_app/language/languages.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/onboarding_consts.dart';
import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubit/states/app_states.dart';

import 'on_board_model.dart';

class OnBoardingViewModel {
  PageController pageController = PageController();

  Languages lang = isAppArabic ? ArabicLanguage() : EnglishLanguage();

  late String finish;
  late String next;
  late String skip;
  late String title1_1;
  late String title1_2;
  late String title2_1;
  late String title2_2;
  late String title3_1;
  late String title3_2;
  late String title4_1;
  late String title4_2;
  late String body;
  late List<OnBoardItemDetails> boards;

  OnBoardingViewModel() {
    finish = '${lang.onBoardingMap['finish']}';
    next = '${lang.onBoardingMap['next']}';
    skip = '${lang.onBoardingMap['skip']}';
    title1_1 = '${lang.onBoardingMap['title1_1']}';
    title1_2 = '${lang.onBoardingMap['title1_2']}';
    title2_1 = '${lang.onBoardingMap['title2_1']}';
    title2_2 = '${lang.onBoardingMap['title2_2']}';
    title3_1 = '${lang.onBoardingMap['title3_1']}';
    title3_2 = '${lang.onBoardingMap['title3_2']}';
    title4_1 = '${lang.onBoardingMap['title4_1']}';
    title4_2 = '${lang.onBoardingMap['title4_2']}';
    body = '${lang.onBoardingMap['body']}';

    boards = [];
    boards.add(OnBoardItemDetails(
        imagePath: 'assets/images/onBoarding_1.PNG',
        title_1: title1_1,
        title_2: title1_2,
        details: body));
    boards.add(OnBoardItemDetails(
        imagePath: 'assets/images/onBoarding_2.PNG',
        title_1: title2_1,
        title_2: title2_2,
        details: body));
    boards.add(OnBoardItemDetails(
        imagePath: 'assets/images/onBoarding_3.PNG',
        title_1: title3_1,
        title_2: title3_2,
        details: body));
    boards.add(OnBoardItemDetails(
        imagePath: 'assets/images/onBoarding_4.PNG',
        title_1: title4_1,
        title_2: title4_2,
        details: body));
  }

  void changeBoardingPage(int myCurrentPage, context) {
    currentPage = myCurrentPage;
    AppCubit.get(context).changeState(AppChangeBoardingState());
  }

  Color onBoardPrimaryColor = cardColor;

  TextStyle onBoardingTextStyle =
      TextStyle(color: cardColor, fontWeight: FontWeight.bold, fontSize: 18);

  TextStyle onBoardTitleStyle =
      TextStyle(color: cardColor, fontSize: 20, fontWeight: FontWeight.bold);
}
