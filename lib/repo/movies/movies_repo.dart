import 'package:dartz/dartz.dart';
import 'package:movie_db_app/data/models/failure.dart';
import 'package:movie_db_app/data/models/movie_detail_model.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';

abstract class MoviesRepo{
  Future<Either<Failure, UpComingMovies>> getUpcomingMovies({required int pageNumber});
  Future<Either<Failure, MovieDetail>> getMovieDetail({required int movieId});
}