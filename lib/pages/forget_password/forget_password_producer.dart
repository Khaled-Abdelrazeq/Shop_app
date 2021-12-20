import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/forget_password/forget_password_model.dart';
import 'package:shop_app/pages/forget_password/forget_password_view_model.dart';
import 'package:shop_app/shared/contsts/constants.dart';
import 'package:shop_app/shared/cubit/cubits/forget_password_cubit.dart';
import 'package:shop_app/shared/cubit/states/forget_password_states.dart';

class ForgetPasswordProducer {
  void sendCodeToMail(context, email) {
    ForgetPasswordCubit.get(context).changeState(ForgetPasswordSentCodeState());
    DioHandler.postData(path: verifyEmailEndPoint, data: {
      'email': email,
    }).then((value) {
      ForgetPasswordViewModel.forgetPasswordModel =
          ForgetPasswordModel.fromJson(value.data);
      ForgetPasswordViewModel.codeSent = true;
      print(value.data);
      print(ForgetPasswordViewModel.forgetPasswordModel?.message);

      addToastMessage();

      ForgetPasswordCubit.get(context)
          .changeState(ForgetPasswordCodeSuccessState());
    }).catchError((e) {
      print('Error when sending code $e');
      ForgetPasswordCubit.get(context)
          .changeState(ForgetPasswordCodeFailedState());
    });
  }

  void resetPassword(context, email, code, password) {
    ForgetPasswordCubit.get(context)
        .changeState(ForgetPasswordChangeLoadingState());
    DioHandler.postData(path: resetPasswordEndPoint, data: {
      'email': email,
      'code': code,
      'password': password,
    }).then((value) {
      ForgetPasswordViewModel.forgetPasswordModel =
          ForgetPasswordModel.fromJson(value.data);
      print(value.data);
      print(ForgetPasswordViewModel.forgetPasswordModel?.message);
      addToastMessage();
      ForgetPasswordCubit.get(context)
          .changeState(ForgetPasswordChangePasswordSuccessState());
    }).catchError((e) {
      print('Error when sending code $e');
      ForgetPasswordCubit.get(context)
          .changeState(ForgetPasswordChangePasswordFailedState());
    });
  }

  void addToastMessage() {
    if (ForgetPasswordViewModel.forgetPasswordModel?.status ?? false) {
      addToast(
          msg: '${ForgetPasswordViewModel.forgetPasswordModel?.message}',
          type: ToastType.success);
    } else {
      addToast(
          msg: '${ForgetPasswordViewModel.forgetPasswordModel?.message}',
          type: ToastType.error);
    }
  }
}
