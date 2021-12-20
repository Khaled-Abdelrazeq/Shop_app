import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/login/login_page.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/cubit/cubits/forget_password_cubit.dart';
import 'package:shop_app/shared/cubit/states/forget_password_states.dart';

import 'forget_password_view_model.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);

  ForgetPasswordViewModel forgetPassword = ForgetPasswordViewModel();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ForgetPasswordCubit(),
      child: BlocConsumer<ForgetPasswordCubit, ForgetPasswordStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text(forgetPassword.title),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ForgetPasswordViewModel.codeSent
                    ? Column(
                        children: [
                          textField(
                            context: context,
                            controller: forgetPassword.codeController,
                            labelText: forgetPassword.codeText,
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.password,
                            validateText: forgetPassword.validationCode,
                          ),
                          const SizedBox(height: 15),
                          textField(
                            context: context,
                            controller: forgetPassword.newPasswordController,
                            labelText: forgetPassword.newPasswordText,
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.visibility,
                            validateText: forgetPassword.validationPassword,
                          ),
                          const SizedBox(height: 15),
                          buttonField(
                              text: forgetPassword.resetPasswordText,
                              function: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  forgetPassword.resetPassword(
                                      context: context,
                                      code: forgetPassword.codeController.text,
                                      email: forgetPassword.email,
                                      password: forgetPassword
                                          .newPasswordController.text);
                                }
                              }),
                          const SizedBox(height: 15),
                          buttonField(
                              text: forgetPassword.sendCodeAgain,
                              function: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  forgetPassword.sendCodeToUser(
                                      context: context,
                                      email: forgetPassword.email);
                                }
                              }),
                          const SizedBox(height: 15),
                          if (ForgetPasswordViewModel.verified)
                            buttonField(
                                text: forgetPassword.gotoLogin,
                                function: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                })
                        ],
                      )
                    : Column(
                        children: [
                          textField(
                            context: context,
                            controller: forgetPassword.emailController,
                            labelText: forgetPassword.emailText,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: Icons.email,
                            isValidationEmail: true,
                            validateText: forgetPassword.validationEmail,
                          ),
                          const SizedBox(height: 15),
                          buttonField(
                              text: forgetPassword.getCode,
                              function: () {
                                if (formKey.currentState?.validate() ?? false) {
                                  forgetPassword.email =
                                      forgetPassword.emailController.text;
                                  forgetPassword.sendCodeToUser(
                                      context: context,
                                      email:
                                          forgetPassword.emailController.text);
                                }
                              })
                        ],
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
