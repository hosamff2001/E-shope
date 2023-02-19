import 'package:bottom_bar/bottom_bar.dart';
import 'package:eshop/modules/login/login_screen.dart';
import 'package:eshop/shared/app_cubit/cubit.dart';
import 'package:eshop/shared/app_cubit/stats.dart';
import 'package:eshop/shared/components/components.dart';
import 'package:eshop/shared/components/constants.dart';
import 'package:eshop/shared/network/local/cashmemory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../modules/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getproducat()
        ..getcategories()
        ..getuserdata(),
      child: BlocConsumer<AppCubit, ShopAppStats>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.GetObject(context);
          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      onPressed: () {
                        navigateTo(context, SearchScreen());
                      },
                      icon: Icon(Icons.search)),
                  IconButton(
                      onPressed: () {
                        CashHelper.removedata(key: "token");
                        CashHelper.removedata(key: "login");
                        navigateAndFinish(context, LoginScreen());
                      },
                      icon: Icon(Icons.logout))
                ],
                title: Text("Salla"),
              ),
              body: cubit.screen[cubit.currentpage],
              bottomNavigationBar: BottomBar(
                selectedIndex: cubit.currentpage,
                onTap: (int index) {
                  cubit.changebottom(index);
                },
                items: <BottomBarItem>[
                  BottomBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                    activeColor: Colors.blue,
                  ),
                  BottomBarItem(
                    icon: Icon(Icons.favorite),
                    title: Text('Favorites'),
                    activeColor: Colors.red,
                  ),
                  BottomBarItem(
                    icon: Icon(Icons.category),
                    title: Text('Category'),
                    activeColor: Colors.greenAccent.shade700,
                  ),
                  BottomBarItem(
                    icon: Icon(Icons.settings),
                    title: Text('Settings'),
                    activeColor: Colors.orange,
                  ),
                ],
              ));
        },
      ),
    );
  }
}


// MaterialButton(
//           child: Text("remove"),
//           onPressed: () => CashHelper.removedata(key: "login"),
//         ),