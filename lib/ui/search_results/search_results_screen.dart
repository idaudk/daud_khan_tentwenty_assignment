import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/search_cubit/search_cubit.dart';
import 'package:movie_db_app/cubits/search_results_cubit/search_results_cubit.dart';
import 'package:movie_db_app/data/models/search_model.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/ui/resources/color_manager.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/search/components/search_list_tile.dart';
import 'package:movie_db_app/ui/search/components/search_screen_appbar.dart';
import 'package:movie_db_app/ui/widgets/appbar/simple_app_bar.dart';
import 'package:movie_db_app/ui/widgets/nav/nav.dart';

class SearchResultScreen extends StatelessWidget {
  String keyword;
  final scrollController = ScrollController();

  SearchResultScreen({required this.keyword, super.key});

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<SearchResultsCubit>(context).loadSearch(keyword);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<SearchResultsCubit>(context).loadSearch(keyword);
    return Scaffold(
      backgroundColor: ColorManager.pageBg,
      // appBar:
      body: Stack(
        children: [
          BlocBuilder<SearchResultsCubit, SearchResultsState>(
            builder: (context, state) {
              if (state is SearchResultsLoading && state.isFirstFetch) {
                return _loadingIndicator();
              }
              if (state is SearchResultsFailed) {
                return const Center(
                  child: Icon(
                    CupertinoIcons.xmark_octagon,
                    color: ColorManager.error,
                  ),
                );
              }

              List<Results> results = [];
              bool isLoading = false;

              if (state is SearchResultsLoading) {
                results = state.preSearchResults;
                isLoading = true;
              } else if (state is SearchResultsLoaded) {
                results = state.searchResults;
              }

              return ListView.builder(
                padding: EdgeInsets.only(
                    left: AppSize.s24,
                    right: AppSize.s24,
                    top: AppSize.s130.h,
                    bottom: AppSize.s130.h),
                // itemCount: results.length + (isLoading ? 1 : 0),
                itemCount: results.length,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (context, index) {
                  var result = results[index];
                  if (index < results.length) {
                    return SearchListTIle(result, context);
                  } else {
                    Timer(const Duration(seconds: 3), () {
                      scrollController
                          .jumpTo(scrollController.position.maxScrollExtent);
                    });
                    return _loadingIndicator();
                  }
                },
              );
            },
          ),
          Positioned(
              top: 1,
              child: BlocBuilder<SearchResultsCubit, SearchResultsState>(
                builder: (context, state) {
                  return SearchScreenSimpleAppbar(
                      title:
                          '${context.read<SearchResultsCubit>().totalResults} Results Found');
                },
              )),
          const BottomNav()
        ],
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
