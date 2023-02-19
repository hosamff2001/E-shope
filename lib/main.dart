import 'package:eshop/layout/shoplayout.dart';
import 'package:eshop/modules/Onborading/on_borading_screen.dart';
import 'package:eshop/modules/login/login_screen.dart';
import 'package:eshop/shared/app_cubit/cubit.dart';
import 'package:eshop/shared/app_cubit/stats.dart';
import 'package:eshop/shared/network/local/cashmemory.dart';
import 'package:eshop/shared/network/rempte/dio.dart';
import 'package:eshop/shared/styles/styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CashHelper.init();
  late Widget screen;
  var onbording = await CashHelper.getdata(key: "onBording");
  var login = await CashHelper.getdata(key: "login");
  
  if (onbording != null) {
    if (login != null) {
      screen = ShopLayout();
    } else {
      screen = LoginScreen();
    }
  } else {
    screen = OnBordingScreen();
  }
  runApp(MyApp(Screen: screen));
}

class MyApp extends StatelessWidget {
  Widget? Screen;
  MyApp({this.Screen});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit, ShopAppStats>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: themeData,
            home: Screen,
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
