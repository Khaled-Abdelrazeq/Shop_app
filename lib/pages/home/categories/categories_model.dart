class CategoriesModel {
  bool? status;
  CategoriesDataModel? dataModel;

  CategoriesModel(this.status, this.dataModel);

  CategoriesModel.fromJson(dynamic data) {
    status = data['status'];
    if (data['data'] != null) {
      dataModel = CategoriesDataModel.fromJson(data['data']);
    }
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<CategoriesDataDetailsModel> detailsData = [];

  CategoriesDataModel.fromJson(dynamic data) {
    currentPage = data['currentPage'];
    if (data['data'] != null) {
      data['data'].forEach((element) =>
          detailsData.add(CategoriesDataDetailsModel.fromJson(element)));
    }
  }
}

class CategoriesDataDetailsModel {
  int? id;
  String? name;
  String? image;

  CategoriesDataDetailsModel.fromJson(dynamic data) {
    id = data['id'];
    name = data['name'];
    image = data['image'];
  }
}
