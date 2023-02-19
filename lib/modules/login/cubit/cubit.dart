import 'package:eshop/models/login_model/loginmodel.dart';
import 'package:eshop/modules/login/cubit/states.dart';
import 'package:eshop/shared/network/rempte/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/constants.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(initialstateLogin());
  late ShopLogin User;
  static LoginCubit getobject(context) => BlocProvider.of(context);

  void Login({required String email, required String password}) {
    emit(loadingstateLogin());
    DioHelper.post(url: LOGIN, data: {"email": email, "password": password})
        .then((value) {
      User = ShopLogin.fromjson(value.data);

      emit(sucesslstateLogin(User));
    }).catchError((error) {
      emit(errorstateLogin(error));
    });
  }

  bool show = true;
  void changeobserve() {
    show = !show;
    emit(changepasswordstateLogin());
  }

  void Register(
      {required String email,
      required String password,
      required String phone,
      required String name}) {
    emit(loadingstateRegister());
    DioHelper.post(url: REGISTER, data: {
      "email": email,
      "password": password,
      "phone": phone,
      "name": name
    }).then((value) {
      User = ShopLogin.fromjson(value.data);

      emit(sucesslstateRegister(User));
    }).catchError((error) {
      emit(errorstateRegister(error));
    });
  }
}
