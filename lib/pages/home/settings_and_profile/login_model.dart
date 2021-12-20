class LoginModel {
  bool? status;
  String? message;
  DataLoginMessage? data;

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = DataLoginMessage.fromJson(json['data']);
    }
  }
}

class DataLoginMessage {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? point;
  int? credit;
  String? token;

  DataLoginMessage.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];
  }
}
