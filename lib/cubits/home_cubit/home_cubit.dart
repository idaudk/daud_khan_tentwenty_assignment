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
    print('get movies');
    emit(HomeLoading());
    await moviesRepoImpl
        .getUpcomingMovies(pageNumber: pageNumber)
        .onError((error, stackTrace) => emit(HomeFailed()))
        .then((value) {
      print(value);
    });
  }
}
