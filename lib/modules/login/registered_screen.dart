import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shoplayout.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cashmemory.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
   final formkey = GlobalKey<FormState>();
  var nameconttroler = TextEditingController();
  var phoneconttroler = TextEditingController();
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
                            "Register",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                          Text(
                            "Register now to get ower offer now",
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
                                return "name is not valided";
                              }
                              return null;
                            },
                            hint: "name",
                            controller: nameconttroler,
                            prefixicon: Icons.person,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.01,
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
                            height: MediaQuery.of(context).size.height * 0.01,
                          ),
                          defaultTextFormfiled(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "phone is not valided";
                              }
                              return null;
                            },
                            hint: "phone number",
                            controller: phoneconttroler,
                            prefixicon: Icons.message,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          state is! loadingstateLogin
                              ? defaultButton(
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      LoginCubit.getobject(context).Register(
                                          email: emailconttroler.text,
                                          password: passwordconttroler.text,
                                          name: nameconttroler.text,
                                          phone: phoneconttroler.text);
                                    }
                                  },
                                  text: "REGISTER")
                              : Center(child: CircularProgressIndicator()),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                         
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          listener: (context, state) async{
            if (state is sucesslstateRegister) {
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
