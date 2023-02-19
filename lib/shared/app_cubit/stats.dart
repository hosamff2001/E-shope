import '../../models/login_model/loginmodel.dart';

abstract class ShopAppStats {}

class ShopAppinitial extends ShopAppStats {}

class ShopAppchangescreen extends ShopAppStats {}

class ShopAppsucssess extends ShopAppStats {}

class ShopApploading extends ShopAppStats {}

class ShopApperror extends ShopAppStats {}

class ShopAppcategoriesloading extends ShopAppStats {}

class ShopAppcategoriessucssess extends ShopAppStats {}

class ShopAppcategorieserror extends ShopAppStats {}

class ShopAppchangefavoritesucssess extends ShopAppStats {}

class ShopAppchangefavoriteerror extends ShopAppStats {}

class ShopAppUserDataloading extends ShopAppStats {}

class ShopAppUserDatasucssess extends ShopAppStats {}

class ShopAppUserDataerror extends ShopAppStats {}

class ShopAppUpdateUserDataloading extends ShopAppStats {}

class ShopAppUpdateUserDatasucssess extends ShopAppStats {
  final ShopLogin shopLoginmodel;

  ShopAppUpdateUserDatasucssess(this.shopLoginmodel);
}

class ShopAppUpdateUserDataerror extends ShopAppStats {}
