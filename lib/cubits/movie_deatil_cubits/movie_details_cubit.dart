import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_db_app/data/models/movie_detail_model.dart';
import 'package:movie_db_app/data/models/movie_trailer_model.dart';
import 'package:movie_db_app/data/models/movies_images_model.dart';
import 'package:movie_db_app/repo/movies/movies_repo_impl.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final int movieId;
  final MoviesRepoImpl _moviesRepoImpl = MoviesRepoImpl();

  MovieDetailsCubit({required this.movieId}) : super(MovieDetailsInitial()) {
    getMovieDetail(movieId: movieId);
  }

  getMovieDetail({required int movieId}) async {
    emit(MovieDetailsLoading());
    final movieDetail = await _moviesRepoImpl.getMovieDetail(movieId: movieId);
    movieDetail.fold((l) async {
      //ERROR
      emit(MovieDetailsFailed());
    }, (movieDetailResponse) async {
      final movieImages =
          await _moviesRepoImpl.getMovieImages(movieId: movieId);
      movieImages.fold((l) {
        //ERROR
        emit(MovieDetailsFailed());
      }, (movieImagesResponse) async {
        final movieTrailer =
            await _moviesRepoImpl.getMovieTrailer(movieId: movieId);
        movieTrailer.fold((l) {
          emit(MovieDetailsFailed());
        }, (movieTrailerResponse) {
          emit(MovieDetailsLoaded(
              movieTrailer: movieTrailerResponse,
              movieDetail: movieDetailResponse,
              movieImages: movieImagesResponse));
        });
      });
    });
  }
}
