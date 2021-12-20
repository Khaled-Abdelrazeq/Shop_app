import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/pages/home/search/search_view_model.dart';
import 'package:shop_app/shared/components.dart';
import 'package:shop_app/shared/cubit/cubits/search_cubit.dart';
import 'package:shop_app/shared/cubit/cubits/shop_cubit.dart';
import 'package:shop_app/shared/cubit/states/search_states.dart';

class SearchScreen extends StatelessWidget {
  final String searchValue;
  SearchScreen({Key? key, required this.searchValue}) : super(key: key);
  SearchViewModel search = SearchViewModel();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SearchCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ShopCubit(),
        ),
      ],
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          if (state is SearchInitState) {
            search.getSearchItems(context: context, searchValue: searchValue);
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(search.title),
              centerTitle: true,
              actions: [
                animSearch(
                    widthSpace: 0,
                    context: context,
                    controller: search.searchController,
                    function: () {
                      if (search.searchController.text.isNotEmpty) {
                        search.getSearchItems(
                            context: context,
                            searchValue: search.searchController.text);
                      }
                    })
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 5),
                if (state is SearchInitState || state is SearchLoadingState)
                  const LinearProgressIndicator(),
                ConditionalBuilder(
                    condition: SearchViewModel.searchModel != null,
                    fallback: (context) => const Text(''),
                    builder: (context) {
                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return search.searchItem(
                                  context,
                                  SearchViewModel
                                      .searchModel?.dataModel?.data2[index]);
                            },
                            separatorBuilder: (context, index) =>
                                Container(height: 1),
                            itemCount: SearchViewModel
                                    .searchModel?.dataModel?.data2.length ??
                                0),
                      );
                    }),
              ],
            ),
          );
        },
      ),
    );
  }
}
