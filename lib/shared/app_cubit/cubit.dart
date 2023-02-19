import 'package:eshop/models/login_model/loginmodel.dart';
import 'package:eshop/models/product_model/productmodel.dart';
import 'package:eshop/shared/app_cubit/stats.dart';
import 'package:eshop/shared/components/constants.dart';
import 'package:eshop/shared/network/local/cashmemory.dart';
import 'package:eshop/shared/network/rempte/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/categorie_model/categoriemodel.dart';
import '../../models/favorites_model/favoritemodel.dart';
import '../../modules/category/category_screen.dart';
import '../../modules/favorites/favorite_screen.dart';
import '../../modules/products/product_screen.dart';
import '../../modules/settings/settings_screen.dart';

class AppCubit extends Cubit<ShopAppStats> {
  AppCubit():super(ShopAppinitial());
  int currentpage = 0;
  static AppCubit GetObject(context) => BlocProvider.of(context);
  void changebottom(int index) {
    currentpage = index;
    emit(ShopAppchangescreen());
  }

  List<Widget> screen = [
    ProductScreen(),
    FavoriteScreen(),
    CategoryScreen(),
    SettingsScreen()
  ];
  Map<int, bool> productsfavorites = {};
  ProductsDataModel? products;
  List<ProductModel> favoriteslist = [];
  void getproducat() async {
    Token = await CashHelper.getdata(key: "token");
    emit(ShopApploading());
    DioHelper.get(url: HOME, token: Token).then((value) {
      products = ProductsDataModel.fromjson(value.data);
      products!.data!.products.forEach(
        (element) {
          productsfavorites[element.id as int] = element.in_favorites as bool;
          if (element.in_favorites) {
            favoriteslist.add(element);
          }
        },
      );
      print(favoriteslist.length);
      print(productsfavorites);
      emit(ShopAppsucssess());
    }).catchError((e) {
      print(e.toString());
      emit(ShopApperror());
    });
  }

  CategoriesModel? categories;
  void getcategories() {
    emit(ShopAppcategoriesloading());
    DioHelper.get(url: CATEGRIES).then((value) {
      categories = CategoriesModel.fromjson(value.data);

      emit(ShopAppcategoriessucssess());
    }).catchError((e) {
      print(e.toString());
      emit(ShopAppcategorieserror());
    });
  }

  FavoritesModel? favorites;
  void changefavorit(dynamic productid) async {
    Token = await CashHelper.getdata(key: "token");
    print(Token);
    DioHelper.post(url: FAVORITE, data: {"product_id": productid}, token: Token)
        .then((value) {
      favorites = FavoritesModel.fromjson(value.data);

      if (favorites!.status == true) {
        productsfavorites[productid] = !productsfavorites[productid]!;
        print(productsfavorites[productid]);
        if (productsfavorites[productid]!) {
          products!.data!.products.forEach((element) {
            if (element.id == productid) {
              favoriteslist.add(element);
            }
          });
        } else {
          favoriteslist.forEach((element) {
            if (element.id == productid) {
              favoriteslist.remove(element);
            }
          });
        }
        emit(ShopAppchangefavoritesucssess());
      }
    }).catchError((e) {
      print(productsfavorites);
      print(e.toString());
      emit(ShopAppchangefavoriteerror());
    });
  }

  late ShopLogin User;
  void getuserdata() async{
    emit(ShopAppUserDataloading());
    Token = await CashHelper.getdata(key: "token");
    DioHelper.get(url: PROFILE,token: Token).then((value) {
      User = ShopLogin.fromjson(value.data);

      emit(ShopAppUserDatasucssess());
    }).catchError((e) {
      print(e.toString());
      emit(ShopAppUserDataerror());
    });
  }
  void putuserdata({required String name,required String email,required String phone,}) async{
    emit(ShopAppUpdateUserDataloading());
    Token = await CashHelper.getdata(key: "token");
    DioHelper.put(url: UPDATE_PROFILE,token: Token,data: {
      "name": name,
	"phone": phone,
	"email": email,
    }).then((value) {
      User = ShopLogin.fromjson(value.data);

      emit(ShopAppUpdateUserDatasucssess(User));
    }).catchError((e) {
      print(e.toString());
      emit(ShopAppUpdateUserDataerror());
    });
  }

}
