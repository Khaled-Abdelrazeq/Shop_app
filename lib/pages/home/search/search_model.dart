class SearchModel {
  dynamic status;
  dynamic message;
  SearchDataModel? dataModel;

  SearchModel.fromJson(Map<String, dynamic> data) {
    status = data['status'];
    message = data['message'];
    if (data['data'] != null) {
      dataModel = SearchDataModel.fromJson(data['data']);
    }
  }
}

class SearchDataModel {
  dynamic currentPage;
  List<FavoriteDataDataModel> data2 = [];

  SearchDataModel.fromJson(Map<String, dynamic> data) {
    currentPage = data['current_page'];
    if (data['data'] != null) {
      data['data'].forEach((element) {
        data2.add(FavoriteDataDataModel.fromJson(element));
      });
    }
  }
}

class FavoriteDataDataModel {
  dynamic id;
  dynamic price;
  dynamic image;
  dynamic name;
  dynamic description;
  dynamic inFavorites;
  dynamic inCart;
  List<String> images = [];

  FavoriteDataDataModel.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    price = data['price'];
    image = data['image'];
    name = data['name'];
    description = data['description'];
    inFavorites = data['in_favorites'];
    inCart = data['in_cart'];

    if (data['images'] != null) {
      data['images'].forEach((element) {
        images.add(element);
      });
    }
  }
}
