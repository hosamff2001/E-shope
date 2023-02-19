class ShopLogin {
  bool? status;
  String? message;
  UserData? data;
  ShopLogin.fromjson(Map<String, dynamic> json) {
    this.status = json["status"];
    this.message = json["message"];
    this.data = (json["data"] is Null) ? null : UserData.fromjson(json["data"]);
  }
}

class UserData {
  int? id;
  int? point;
  int? credit;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  //named constractor
  UserData.fromjson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.point = json["point"];
    this.credit = json["credit"];
    this.email = json["email"];
    this.name = json["name"];
    this.phone = json["phone"];
    this.image = json["image"];
    this.token = json["token"];
  }
}
