class ProductsDataModel {
  bool? status;
  Datamodel? data;

  ProductsDataModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = Datamodel.fromjson(json["data"]);
  }
}

class Datamodel {
  List banners = [];
  List products = [];

  Datamodel.fromjson(Map<String, dynamic> json) {
    json["banners"].forEach((value) {
      banners.add(BannerModel.fromjson(value));
    });
    
    json["products"].forEach((value) {
      products.add(ProductModel.fromjson(value));
    });
  }
}

class BannerModel {
  int? id;
  String? image;

  BannerModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class ProductModel {
  int? id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  ProductModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    old_price = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    in_favorites = json["in_favorites"];
    in_cart = json["in_cart"];
  }
}
