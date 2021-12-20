import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/home/favorite/favorite_view_model.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/shop_states.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  FavoriteViewModel favorite = FavoriteViewModel();

  @override
  Widget build(BuildContext context) {
    return ConditionalBuilder(
      condition: true, //FavoriteViewModel.favoriteModel != null,
      fallback: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
      builder: (BuildContext context) {
        return BlocConsumer<ShopCubit, ShopStates>(
          listener: (BuildContext context, state) {},
          builder: (BuildContext context, Object? state) {
            return Column(
              children: [
                ConditionalBuilder(
                  condition: state is! ShopFavoriteLoadingState,
                  fallback: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                  builder: (BuildContext context) {
                    return Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return favorite.favoriteItem(
                                context,
                                FavoriteViewModel.favoriteModel?.dataModel
                                    ?.data2[index].product);
                          },
                          separatorBuilder: (context, index) {
                            return Container(height: 1, color: Colors.grey);
                          },
                          itemCount: FavoriteViewModel
                                  .favoriteModel?.dataModel?.data2.length ??
                              0),
                    );
                  },
                ),
                Container(
                  height: 55,
                )
              ],
            );
          },
        );
      },
    );
  }
}
