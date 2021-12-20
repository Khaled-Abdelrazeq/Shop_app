class FavoriteModel {
  bool? status;
  String? message;
  FavoriteDataModel? dataModel;

  FavoriteModel.fromJsonStatus(dynamic data) {
    status = data['status'];
    message = data['message'];
  }

  FavoriteModel.fromJson(dynamic data) {
    status = data['status'];
    message = data['message'];
    if (data['data'] != null) {
      dataModel = FavoriteDataModel.fromJson(data['data']);
    }
  }
}

class FavoriteDataModel {
  int? currentPage;
  List<FavoriteDataDataModel> data2 = [];

  FavoriteDataModel.fromJson(dynamic data) {
    currentPage = data['current_page'];
    if (data['data'] != null) {
      data['data'].forEach((element) {
        data2.add(FavoriteDataDataModel.fromJson(element));
      });
    }
  }
}

class FavoriteDataDataModel {
  int? id;
  FavoriteProductModel? product;

  FavoriteDataDataModel.fromJson(dynamic data) {
    id = data['id'];
    if (data['product'] != null) {
      product = FavoriteProductModel.fromJson(data['product']);
    }
  }
}

class FavoriteProductModel {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  dynamic? description;
  dynamic? image;
  String? name;

  FavoriteProductModel.fromJson(dynamic data) {
    id = data['id'];
    price = data['price'];
    oldPrice = data['old_price'];
    discount = data['discount'];
    description = data['description'];
    image = data['image'];
    name = data['name'];
  }
}
