import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/local/player_pref.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/home/settings_and_profile/login_model.dart';
import 'package:shop_app/pages/login/login_view_model.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubit/states/app_states.dart';

class LoginProducer {
  void onUserLogin(context, String email, String password) {
    AppCubit.get(context).changeState(AppLoginLoadingState());
    DioHandler.postData(
        path: loginEndPoint,
        data: {'email': email, 'password': password}).then((value) {
      LoginViewModel.loginMessageModel = LoginModel.fromJson(value.data);
      // token = value.data['data']['token'];
      // PlayerPref.setData(key: 'token', value: token);
      AppCubit.get(context).getUserData(context);
      AppCubit.get(context)
          .changeState(AppLoginSuccessState(LoginViewModel.loginMessageModel));
    }).catchError((e) {
      AppCubit.get(context).changeState(AppLoginFailedState());
    });
  }
}
