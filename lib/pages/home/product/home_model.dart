class HomeModelJson {
  bool? status;
  HomeModelJsonData? dataModel;

  HomeModelJson(dynamic data) {
    status = data['status'];
    if (data['data'] != null) {
      dataModel = HomeModelJsonData(data['data']);
    }
  }
}

class HomeModelJsonData {
  List<HomeModelDataBanners> banners = [];
  List<HomeModelDataProducts> products = [];

  HomeModelJsonData(dynamic data) {
    if (data['banners'] != null) {
      // banners = data['banners'];
      data['banners'].forEach((element) {
        banners.add(HomeModelDataBanners(element));
        // print(element);
      });
    }
    if (data['products'] != null) {
      data['products'].forEach((element) {
        products.add(HomeModelDataProducts(element));
      });
    }
  }
}

class HomeModelDataBanners {
  int? id;
  String? image;
  String? category;
  String? product;

  HomeModelDataBanners(dynamic data) {
    id = data['id'];
    image = data['image'];
    category = data['category'];
    product = data['product'];
  }
}

class HomeModelDataProducts {
  int? id;
  dynamic? price;
  dynamic? oldPrice;
  dynamic? discount;
  dynamic? description;
  dynamic? image;
  String? name;
  bool? isInFavorite;
  bool? isInCart;
  List<String> images = [];

  HomeModelDataProducts(dynamic data) {
    id = data['id'];
    price = data['price'];
    oldPrice = data['old_price'];
    discount = data['discount'];
    description = data['description'];
    image = data['image'];
    name = data['name'];
    isInFavorite = data['in_favorites'];
    isInCart = data['in_cart'];
    if (data['images'] != null) {
      data['images'].forEach((element) {
        images.add(element);
      });
    }
  }
}
