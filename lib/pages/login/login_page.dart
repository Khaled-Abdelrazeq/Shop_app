import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/player_pref.dart';
import 'package:shop_app/pages/forget_password/forget_password_screen.dart';
import 'package:shop_app/pages/home/home_page/home_page.dart';
import 'package:shop_app/pages/login/login_view_model.dart';
import 'package:shop_app/pages/register/register_page.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubit/states/app_states.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  LoginViewModel loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppLoginSuccessState) {
          if (state.loginMessageModel.status!) {
            loginViewModel.addSuccessMessage(state.loginMessageModel.message!);
            PlayerPref.setData(
                key: 'token', value: state.loginMessageModel.data?.token);
            token = state.loginMessageModel.data?.token ?? '';
            AppCubit.get(context).getUserData(context);
            AppCubit.get(context).moveToHome(context, HomePage());
          } else {
            loginViewModel.addFailedMessage(state.loginMessageModel.message!);
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        loginViewModel.loginTextTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 80),
                    textField(
                        context: context,
                        controller: emailControllerLogin,
                        keyboardType: TextInputType.emailAddress,
                        labelText: loginViewModel.email,
                        prefixIcon: Icons.email,
                        validateText: loginViewModel.emailValidation),
                    const SizedBox(height: 20),
                    textField(
                        context: context,
                        controller: passwordControllerLogin,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: loginViewModel.password,
                        obscureText: obscureTextLogin,
                        suffixFunction: () {
                          obscureTextLogin = !obscureTextLogin;
                          cubit.changeObscureTextLogin(check: obscureTextLogin);
                        },
                        onSubmittedFunction: (_) {
                          if (formKey.currentState!.validate()) {
                            loginViewModel.onUserLogin(
                                context: context,
                                email: emailControllerLogin.text,
                                password: passwordControllerLogin.text);
                            currentBottomNavIndex = 0;
                          }
                        },
                        prefixIcon: Icons.lock,
                        suffixIcon: obscureTextLogin
                            ? Icons.visibility_off
                            : Icons.visibility,
                        validateText: loginViewModel.passwordValidation),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgetPasswordScreen()));
                        },
                        child: Text(loginViewModel.forgetPassword)),
                    const SizedBox(height: 40),
                    ConditionalBuilder(
                      condition: state is! AppLoginLoadingState,
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      builder: (BuildContext context) => buttonField(
                          text: loginViewModel.buttonTextLogin,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              loginViewModel.onUserLogin(
                                  context: context,
                                  email: emailControllerLogin.text,
                                  password: passwordControllerLogin.text);
                              currentBottomNavIndex = 0;
                            }
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isAppArabic) signOutButton(context),
                        Text(
                          loginViewModel.donotHaveAccount,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 12),
                        ),
                        if (!isAppArabic) signOutButton(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  TextButton signOutButton(BuildContext context) {
    return TextButton(
      child: Text(
        loginViewModel.signUpText,
        style: TextStyle(color: cardColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RegisterPage()));
      },
    );
  }
}
