import 'package:eshop/layout/shoplayout.dart';
import 'package:eshop/modules/login/cubit/cubit.dart';
import 'package:eshop/modules/login/cubit/states.dart';
import 'package:eshop/modules/login/registered_screen.dart';
import 'package:eshop/shared/components/components.dart';
import 'package:eshop/shared/components/constants.dart';
import 'package:eshop/shared/network/local/cashmemory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  final formkey = GlobalKey<FormState>();
  var emailconttroler = TextEditingController();
  var passwordconttroler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          builder: (context, state) {
            return Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.08),
                    child: Form(
                      key: formkey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            "Login now to get ower offer now",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          defaultTextFormfiled(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email is not valided";
                              }
                              return null;
                            },
                            hint: "Email Address",
                            controller: emailconttroler,
                            prefixicon: Icons.message,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          defaultTextFormfiled(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password is short";
                              }
                              return null;
                            },
                            hint: "password".toUpperCase(),
                            controller: passwordconttroler,
                            prefixicon: Icons.lock,
                            suffixIcon: Icons.visibility,
                            ispassword: LoginCubit.getobject(context).show,
                            suffixfunction: () {
                              LoginCubit.getobject(context).changeobserve();
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          state is! loadingstateLogin
                              ? defaultButton(
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      LoginCubit.getobject(context).Login(
                                          email: emailconttroler.text,
                                          password: passwordconttroler.text);
                                    }
                                  },
                                  text: "LOGIN")
                              : Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Text("Not have account !!?"),
                          Row(
                            children: [
                              Text("Don't worry you can "),
                              defaulttextbutton(
                                text: "Register here",
                                onpressed: () =>
                                    navigateTo(context, RegisterScreen()),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (context, state) async{
            if (state is sucesslstateLogin) {
              if (state.shopLoginmodel.status == true) {
                
                Token = state.shopLoginmodel.data!.token ?? "";
                await CashHelper.setdata(key: "token", value: Token)
                    .then((value) => null);
                    
                CashHelper.setdata(key: "login", value: true).then((value) {
                  if (value) {
                    Showtoast(
                        msg: state.shopLoginmodel.message as String,
                        color: ToastStates.SUCCESS);
                    

                    navigateAndFinish(context, ShopLayout());
                  }
                });
              } else if (state.shopLoginmodel.status == false) {
                Showtoast(
                    msg: state.shopLoginmodel.message as String,
                    color: ToastStates.ERROR);
              }
            }
          },
        ));
  }
}
