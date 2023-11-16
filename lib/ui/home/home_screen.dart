import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/cubits/home_cubit/home_cubit.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/routes/route_generator.dart';
import 'package:movie_db_app/ui/home/components/movie_banner.dart';
import 'package:movie_db_app/ui/resources/resources.dart';
import 'package:movie_db_app/ui/widgets/appbar/simple_app_bar.dart';
import 'package:movie_db_app/ui/widgets/gap/gap.dart';
import 'package:movie_db_app/ui/widgets/image/custom_image.dart';
import 'package:movie_db_app/ui/widgets/nav/nav.dart';

class HomeScreen extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<HomeCubit>(context).loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.portraitUp,
    ]);

    setupScrollController(context);
    BlocProvider.of<HomeCubit>(context).loadPosts();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: ColorManager.transparent, // status bar color
    //   statusBarBrightness: Brightness.light,
    //   statusBarIconBrightness: Brightness.light,
    // ));
    return Scaffold(
      backgroundColor: ColorManager.almostWhite,
      appBar: const SimpleAppBar(),
      body: RefreshIndicator.adaptive(
        onRefresh: () async {
          // context.read<HomeCubit>().refreshHandler();
        },
        child: Stack(
          children: [
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading && state.isFirstFetch) {
                  return _loadingIndicator();
                }
                if (state is HomeFailed) {
                  return const Center(
                    child: Icon(
                      CupertinoIcons.xmark_octagon,
                      color: ColorManager.error,
                    ),
                  );
                }

                List<Results> movies = [];
                bool isLoading = false;

                if (state is HomeLoading) {
                  movies = state.preUpcomingMovies;
                  isLoading = true;
                } else if (state is HomeLoaded) {
                  movies = state.upcomingMovies;
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(AppSize.s24),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  //  itemCount: movies.length + (isLoading ? 1 : 0),
                  itemCount: movies.length,
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    var movie = movies[index];
                    if (index < movies.length) {
                      return MovieBanner(
                        movieId: movie.id!,
                        title: movie.title.toString(),
                        imageLink: BaseApiService.imageBaseUrl +
                            movie.backdropPath.toString(),
                      );
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
            const BottomNav()
          ],
        ),
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
