import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/repo/movies/movies_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MoviesRepoImpl _moviesRepoImpl = MoviesRepoImpl();

  int page = 1;

  // List<Results> movies = <Results>[];
  // ScrollController scrollController = ScrollController();

  HomeCubit() : super(HomeInitial()) {
    // getMovies(pageNumber: currentPage);
    // scrollController.addListener(_scrollListener);
  }

  void loadPosts() async {
    print('loadPost called');
    if (state is HomeLoading) return;

    final currentState = state;

    var prevUpcomingMovies = <Results>[];
    if (currentState is HomeLoaded) {
      prevUpcomingMovies = currentState.upcomingMovies;
    }

    emit(HomeLoading(prevUpcomingMovies, isFirstFetch: page == 1));

    await _moviesRepoImpl.getUpcomingMovies(pageNumber: page).then((value) {
      print(value);
      value.fold((l) {
        emit(HomeFailed());
      }, (newMovies) {
        if (newMovies.totalPages! >= page) {
          page++;
          final movies = (state as HomeLoading).preUpcomingMovies;
          movies.addAll(newMovies.results!);
          emit(HomeLoaded(movies));
        }
      });
    });
  }

  // void _scrollListener() {
  //   if (scrollController.position.pixels ==
  //       scrollController.position.maxScrollExtent) {
  //     loadMoreMovies();
  //   }
  // }

  // refreshHandler() async {
  //   emit(HomeLoading());
  //   final response = await moviesRepoImpl.getUpcomingMovies(pageNumber: 1);
  //   response.fold((l) {
  //     emit(HomeFailed());
  //   }, (r) {
  //     currentPage = r.page!;
  //     movies = r.results!;
  //     emit(HomeLoaded(upcomingMovies: movies));
  //   });
  // }

  // getMovies({required int pageNumber}) async {
  //   // ignore: avoid_print
  //   print('called');
  //   emit(HomeLoading());
  //   final response =
  //       await moviesRepoImpl.getUpcomingMovies(pageNumber: pageNumber);
  //   response.fold((l) {
  //     emit(HomeFailed());
  //   }, (r) {
  //     currentPage = r.page!;
  //     movies.addAll(r.results!);
  //     maxPages = r.totalPages!;
  //     emit(HomeLoaded(upcomingMovies: movies));
  //   });
  // }

  // loadMoreMovies() async {
  //   print('loading More');
  //   if (currentPage <= maxPages) {
  //     emit(HomeLoadingMore());
  //     int nextPage = currentPage + 1;
  //     print('next page : $nextPage');
  //     final response = await moviesRepoImpl.getUpcomingMovies(
  //         pageNumber: currentPage + nextPage);
  //     response.fold((l) {
  //       emit(HomeLoaded(upcomingMovies: movies));
  //     }, (r) {
  //       currentPage++;
  //       movies.addAll(r.results!);
  //       emit(HomeLoaded(upcomingMovies: movies));
  //       print('more movies added!');
  //     });
  //   }
  //   // final Response
  // }
}
