import 'package:shop_app/pages/home/settings_and_profile/login_model.dart';

abstract class AppStates {}

class AppInitState extends AppStates {}

class AppChangeBoardingState extends AppStates {}

class AppMoveToNextPageState extends AppStates {}

class AppMoveToHomePageState extends AppStates {}

class AppChangeObscureTextLoginState extends AppStates {}

// -----------------------Login States --------------------------
class AppLoginLoadingState extends AppStates {}

class AppLoginSuccessState extends AppStates {
  final LoginModel loginMessageModel;

  AppLoginSuccessState(this.loginMessageModel);
}

class AppLoginFailedState extends AppStates {}

// -----------------------Register States ------------------------
class AppRegisterLoadingState extends AppStates {}

class AppRegisterSuccessState extends AppStates {
  final LoginModel registerMessageModel;

  AppRegisterSuccessState(this.registerMessageModel);
}

class AppRegisterFailedState extends AppStates {}

class AppGetUserDataState extends AppStates {}
