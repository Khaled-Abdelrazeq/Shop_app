import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/home/settings_and_profile/login_model.dart';
import 'package:shop_app/pages/register/register_view_model.dart';
import 'package:shop_app/shared/cubit/cubits/app_cubit.dart';
import 'package:shop_app/shared/cubit/states/app_states.dart';

class RegisterProducer {
  void postRegisterData(
      context, String username, String email, String password, String phone) {
    AppCubit.get(context).changeState(AppRegisterLoadingState());

    DioHandler.postData(path: registerEndPoint, data: {
      'name': username,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      RegisterViewModel.registerModel = LoginModel.fromJson(value.data);
      AppCubit.get(context).changeState(
          AppRegisterSuccessState(RegisterViewModel.registerModel));
    }).catchError((e) {
      print('Error when register new user $e');
      AppCubit.get(context).changeState(AppRegisterFailedState());
    });
  }
}
