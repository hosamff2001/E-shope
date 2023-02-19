class FavoritesModel {
  bool? status;
  String? message;
  FavoritesModel.fromjson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
  }
}
