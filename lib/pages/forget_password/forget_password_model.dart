class ForgetPasswordModel {
  bool? status;
  String? message;
  ForgetPasswordDataModel? dataModel;

  ForgetPasswordModel.fromJson(dynamic data) {
    status = data['status'];
    message = data['message'];
    if (data['data'] != null) {
      dataModel = ForgetPasswordDataModel.fromJson(data['data']);
    }
  }
}

class ForgetPasswordDataModel {
  String? email;

  ForgetPasswordDataModel.fromJson(dynamic data) {
    email = data['email'];
  }
}
