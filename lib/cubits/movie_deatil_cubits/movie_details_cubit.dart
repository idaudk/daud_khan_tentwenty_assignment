import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_db_app/data/models/movie_detail_model.dart';
import 'package:movie_db_app/repo/movies/movies_repo_impl.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MoviesRepoImpl _moviesRepoImpl = MoviesRepoImpl();

  MovieDetailsCubit() : super(MovieDetailsInitial()) {
    getMovieDetail(movieId: 951491);
  }

  getMovieDetail({required int movieId}) async {
    emit(MovieDetailsLoading());
    print('getting detail');
    final response = await _moviesRepoImpl.getMovieDetail(movieId: movieId);
    print(response);
  }
}
