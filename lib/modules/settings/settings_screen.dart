import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eshop/shared/app_cubit/cubit.dart';
import 'package:eshop/shared/components/components.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/app_cubit/stats.dart';

class SettingsScreen extends StatelessWidget {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, ShopAppStats>(builder: (context, state) {
      var user = AppCubit.GetObject(context).User;
      emailcontroller.text = user.data!.email ?? "";
      namecontroller.text = user.data!.name ?? "";
      phonecontroller.text = user.data!.phone ?? "";
      return ConditionalBuilder(
        condition: user != null,
        fallback: (context) => Center(child: CircularProgressIndicator()),
        builder: (context) => Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  if (state is ShopAppUpdateUserDataloading)
                    LinearProgressIndicator(),
                  Text(
                    "Hello ${user.data!.name}",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Your Data",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  defaultTextFormfiled(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "name is Empty";
                        }
                        return null;
                      },
                      hint: namecontroller.text,
                      controller: namecontroller,
                      prefixicon: Icons.person),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormfiled(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "email is Empty";
                        }
                        return null;
                      },
                      hint: emailcontroller.text,
                      controller: emailcontroller,
                      prefixicon: Icons.email),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextFormfiled(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "phone is Empty";
                        }
                        return null;
                      },
                      hint: phonecontroller.text,
                      controller: phonecontroller,
                      prefixicon: Icons.phone),
                  SizedBox(
                    height: 15,
                  ),
                  defaultButton(
                      function: () {
                        if (formkey.currentState!.validate()) {
                          AppCubit.GetObject(context).putuserdata(
                              name: namecontroller.text,
                              email: emailcontroller.text,
                              phone: phonecontroller.text);
                        }
                      },
                      text: "Update your data")
                ],
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is ShopAppUpdateUserDatasucssess) {
        if (state.shopLoginmodel.status == true) {
          Showtoast(
              msg: state.shopLoginmodel.message as String,
              color: ToastStates.SUCCESS);

        
        } else if (state.shopLoginmodel.status == false) {
          Showtoast(
              msg: state.shopLoginmodel.message as String,
              color: ToastStates.ERROR);
        }
      }
    });
  }
}
