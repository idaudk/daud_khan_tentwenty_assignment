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
}
