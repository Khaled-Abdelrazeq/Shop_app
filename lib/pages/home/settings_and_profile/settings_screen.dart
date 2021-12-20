import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/player_pref.dart';
import 'package:shop_app/pages/home/categories/categories_view_model.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/pages/home/product/product_view_model.dart';
import 'package:shop_app/pages/home/settings_and_profile/profile_view_model.dart';
import 'package:shop_app/pages/on_boarding/on_boarding_view_model.dart';
import 'package:shop_app/shared/contsts/onboarding_consts.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';
import '../../on_boarding/on_boarding_page.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';

import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  ProfileViewModel profile = ProfileViewModel();
  OnBoardingViewModel boarding = OnBoardingViewModel();

  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(listener: (context, state) {
      if (state is ShopUpdateProfileSuccessState) {
        if (state.model?.status ?? false) {
          addToast(msg: state.model?.message ?? '', type: ToastType.success);
          profile.getUserData(context);
        } else {
          addToast(msg: state.model?.message ?? '', type: ToastType.error);
        }
      }
    }, builder: (context, state) {
      // if (state is ShopGetUserDataSuccessState) {
      emailController.text = ProfileViewModel.userData?.data?.email ?? '';
      nameController.text = ProfileViewModel.userData?.data?.name ?? '';
      phoneController.text = ProfileViewModel.userData?.data?.phone ?? '';
      // }
      return Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                if (state is ShopUpdateProfileLoadingState)
                  const LinearProgressIndicator(),
                const SizedBox(height: 15),
                textField(
                    context: context,
                    controller: nameController,
                    keyboardType: TextInputType.text,
                    labelText: profile.username,
                    prefixIcon: Icons.person,
                    validateText: profile.nameValidation),
                const SizedBox(height: 20),
                textField(
                    context: context,
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    labelText: profile.email,
                    prefixIcon: Icons.email,
                    validateText: profile.emailValidation),
                const SizedBox(height: 20),
                textField(
                    context: context,
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    labelText: profile.phone,
                    prefixIcon: Icons.phone,
                    validateText: profile.phoneValidation),
                const SizedBox(height: 20),
                buttonField(
                    text: profile.update,
                    function: () {
                      if (formKey.currentState!.validate()) {
                        profile.updateProfile(
                            context: context,
                            email: emailController.text,
                            name: nameController.text,
                            phone: phoneController.text);
                      }
                    }),
                const SizedBox(height: 20),
                buttonField(
                    text: profile.instruction,
                    function: () {
                      currentPage = 0;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnBoardingPage()));
                    }),
                const SizedBox(height: 20),
                buttonField(
                    text: profile.themeApp,
                    function: () {
                      isAppDark = !isAppDark;
                      PlayerPref.setData(key: 'isAppDark', value: isAppDark);
                      profile.changeThemeState(context);
                    }),
                const SizedBox(height: 20),
                buttonField(
                    text: profile.languageApp,
                    function: () {
                      isAppArabic = !isAppArabic;

                      ProductViewModel home = ProductViewModel();
                      ProductViewModel.homeModel = null;
                      home.getHomeData(context);

                      CategoriesViewModel category = CategoriesViewModel();
                      CategoriesViewModel.categoriesModel = null;
                      category.getCategoriesShop(context);

                      FavoriteViewModel favorite = FavoriteViewModel();
                      FavoriteViewModel.favoriteModel = null;
                      favorite.getAllFavoriteData(context);

                      ProfileViewModel profile = ProfileViewModel();
                      ProfileViewModel.userData = null;
                      profile.getUserData(context);

                      PlayerPref.setData(
                          key: 'isAppArabic', value: isAppArabic);
                      profile.changeLanguageState(context);
                    }),
                const SizedBox(height: 20),
                buttonField(
                    text: profile.logOut,
                    function: () {
                      logOut(context, AppCubit.get(context));
                    }),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      );
    });
  }
}
