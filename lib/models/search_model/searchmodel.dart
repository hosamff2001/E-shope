class SearchDataModel {
  bool? status;
  Datamodel? data;

  SearchDataModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    data = Datamodel.fromjson(json["data"]);
  }
}

class Datamodel {
  
  List data = [];

  Datamodel.fromjson(Map<String, dynamic> json) {
   
    json["data"].forEach((value) {
      data.add(DataSearchModel.fromjson(value));
    });
  }
}

class DataSearchModel {
  int? id;
  dynamic? price;
  
 
  String? image;
  String? name;
  bool? in_favorites;
  bool? in_cart;

  DataSearchModel.fromjson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
   
    image = json["image"];
    name = json["name"];
    in_favorites = json["in_favorites"];
    in_cart = json["in_cart"];
  }
}
