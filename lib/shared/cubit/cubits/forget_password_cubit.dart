import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../states/forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(ForgetPasswordInitState());

  static ForgetPasswordCubit get(context) => BlocProvider.of(context);

  void changeState(ForgetPasswordStates state) {
    emit(state);
  }
}
