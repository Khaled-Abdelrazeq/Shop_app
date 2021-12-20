import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/network/local/player_pref.dart';
import 'package:shop_app/pages/home/home_page/home_page.dart';
import 'package:shop_app/pages/login/login_page.dart';
import 'package:shop_app/pages/register/register_view_model.dart';
import 'package:shop_app/shared/colors.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/contsts/home_conts.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubit/states/app_states.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();
  RegisterViewModel register = RegisterViewModel();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {
        if (state is AppRegisterSuccessState) {
          if (state.registerMessageModel.status!) {
            addToast(
                msg: state.registerMessageModel.message!,
                type: ToastType.success);
            PlayerPref.setData(
                key: 'token', value: state.registerMessageModel.data?.token);
            token = state.registerMessageModel.data?.token ?? '';
            AppCubit.get(context).moveToHome(context, HomePage());
            AppCubit.get(context).getUserData(context);
          } else {
            addToast(
                msg: state.registerMessageModel.message!,
                type: ToastType.error);
          }
        }
      },
      builder: (BuildContext context, Object? state) {
        AppCubit cubit = AppCubit.get(context);
        return Form(
          key: formKey,
          child: Scaffold(
            appBar: AppBar(
              // title: const Text('Login'),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        register.registerTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 60),
                    textField(
                        context: context,
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        labelText: register.username,
                        prefixIcon: Icons.person,
                        validateText: register.nameValidation),
                    const SizedBox(height: 20),
                    textField(
                        context: context,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        labelText: register.email,
                        prefixIcon: Icons.email,
                        isValidationEmail: true,
                        validateText: register.emailValidation),
                    const SizedBox(height: 20),
                    textField(
                        context: context,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: register.password,
                        obscureText: obscurePasswordRegister,
                        suffixFunction: () {
                          obscurePasswordRegister = !obscurePasswordRegister;
                          cubit.changeObscureTextLogin(
                              check: obscurePasswordRegister);
                        },
                        prefixIcon: Icons.lock,
                        suffixIcon: obscurePasswordRegister
                            ? Icons.visibility_off
                            : Icons.visibility,
                        validateText: register.passwordValidation),
                    const SizedBox(height: 20),
                    textField(
                        context: context,
                        controller: repeatPasswordController,
                        keyboardType: TextInputType.visiblePassword,
                        labelText: register.confirmPassword,
                        obscureText: obscurePasswordRepeatRegister,
                        suffixFunction: () {
                          obscurePasswordRepeatRegister =
                              !obscurePasswordRepeatRegister;
                          cubit.changeObscureTextLogin(
                              check: obscurePasswordRepeatRegister);
                        },
                        prefixIcon: Icons.lock,
                        suffixIcon: obscurePasswordRepeatRegister
                            ? Icons.visibility_off
                            : Icons.visibility,
                        isValidationConfirmPass: true,
                        validateConfirmPass: register.repeatPasswordValidation2,
                        validateText: register.repeatPasswordValidation),
                    const SizedBox(height: 20),
                    textField(
                        context: context,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        labelText: register.phone,
                        prefixIcon: Icons.phone,
                        validateText: register.phoneValidation),
                    const SizedBox(height: 20),
                    ConditionalBuilder(
                      condition: state is! AppRegisterLoadingState,
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                      builder: (BuildContext context) => buttonField(
                          text: register.registerButton,
                          function: () {
                            if (formKey.currentState!.validate()) {
                              register.registerNewUser(
                                  context: context,
                                  username: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text);
                              currentBottomNavIndex = 0;
                            }
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isAppArabic) loginBtn(context),
                        Text(
                          register.alreadyHaveAccount,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(fontSize: 12),
                        ),
                        if (!isAppArabic) loginBtn(context),
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

  TextButton loginBtn(BuildContext context) {
    return TextButton(
      child: Text(
        register.loginBtn,
        style: TextStyle(color: cardColor, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
    );
  }
}
