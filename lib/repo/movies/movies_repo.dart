import 'package:dartz/dartz.dart';
import 'package:movie_db_app/data/models/failure.dart';
import 'package:movie_db_app/data/models/movie_detail_model.dart';
import 'package:movie_db_app/data/models/movie_trailer_model.dart';
import 'package:movie_db_app/data/models/movies_images_model.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';

abstract class MoviesRepo{
  Future<Either<Failure, UpComingMovies>> getUpcomingMovies({required int pageNumber});
  Future<Either<Failure, MovieDetail>> getMovieDetail({required int movieId});
  Future<Either<Failure, MovieImages>> getMovieImages({required int movieId});
  Future<Either<Failure, MovieTrailer>> getMovieTrailer({required int movieId});
}