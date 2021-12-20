import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_handler.dart';
import 'package:shop_app/pages/home/search/search_model.dart';
import 'package:shop_app/pages/home/search/search_view_model.dart';
import 'package:shop_app/shared/contsts/login_register_const.dart';
import 'package:shop_app/shared/cubit/cubits/search_cubit.dart';
import 'package:shop_app/shared/cubit/states/search_states.dart';

class SearchProducer {
  void getItems(context, String value) {
    SearchCubit.get(context).changeState(SearchLoadingState());

    DioHandler.postData(path: searchEndPoint, auth: token, data: {
      'text': value,
    }).then((value) {
      SearchViewModel.searchModel = SearchModel.fromJson(value.data);

      SearchCubit.get(context).changeState(SearchSuccessState());
    }).catchError((e) {
      print('Error when searching about items $e');
      SearchCubit.get(context).changeState(SearchFailedState());
      // print(SearchViewModel.searchModel.dataModel?.data2[0].image);
    });
  }
}
