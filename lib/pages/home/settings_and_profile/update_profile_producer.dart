import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/home/settings_and_profile/login_model.dart';
import 'package:shop_app/pages/home/settings_and_profile/profile_view_model.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

class UpdateProfileProducer {
  void updateProfile(context, String email, String name, String phone) {
    ShopCubit.get(context).changeState(ShopUpdateProfileLoadingState());

    DioHandler.updateData(path: updateProfileEndPoint, auth: token, data: {
      'name': name,
      'phone': phone,
      'email': email,
    }).then((value) {
      ProfileViewModel.updateProfileModel = LoginModel.fromJson(value.data);
      print(value.data);
      print(ProfileViewModel.updateProfileModel?.message);

      ShopCubit.get(context).changeState(
          ShopUpdateProfileSuccessState(ProfileViewModel.updateProfileModel));
    }).catchError((e) {
      print('Error when updating profile $e');
      ShopCubit.get(context).changeState(ShopUpdateProfileFailedState());
    });
  }
}
