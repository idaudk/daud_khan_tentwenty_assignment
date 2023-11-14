import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/repo/movies/movies_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MoviesRepoImpl moviesRepoImpl = MoviesRepoImpl();
  int page = 1;

  HomeCubit() : super(HomeInitial()) {
    getMovies(pageNumber: page);
  }

  getMovies({required int pageNumber}) async {
    // ignore: avoid_print
    print('called');
    emit(HomeLoading());
    final response =
        await moviesRepoImpl.getUpcomingMovies(pageNumber: pageNumber);
        print(response);
    response.fold((l) {
      emit(HomeFailed());
    }, (r) {
      emit(HomeLoaded(upcomingMovies: r));
    });

    // try {
    //   final response =
    //       await moviesRepoImpl.getUpcomingMovies(pageNumber: pageNumber);
    //   print(response);
    //   emit(HomeLoaded(upcomingMovies: response));
    // } catch (e) {
    //   emit(HomeFailed());
    // }
  }
}
