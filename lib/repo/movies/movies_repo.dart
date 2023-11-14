import 'package:dartz/dartz.dart';
import 'package:movie_db_app/data/models/failure.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';

abstract class MoviesRepo{
  Future<Either<Failure, UpComingMovies>> getUpcomingMovies({required int pageNumber});
}