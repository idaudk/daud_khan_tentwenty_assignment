import 'package:dartz/dartz.dart';
import 'package:movie_db_app/data/models/failure.dart';
import 'package:movie_db_app/data/models/movie_detail_model.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/data/remote/network_api_service.dart';
import 'package:movie_db_app/repo/movies/movies_repo.dart';

import '../../data/remote/base_api_service.dart';

class MoviesRepoImpl extends MoviesRepo {
  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<Either<Failure, UpComingMovies>> getUpcomingMovies(
      {required int pageNumber}) async {
    try {
      final json = await _apiService.getUpcomingMovies(pageNumber: pageNumber);
      print(json);
      final upComingMovies = UpComingMovies.fromJson(json);
      return Right(upComingMovies);
    } catch (e) {
      print(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MovieDetail>> getMovieDetail(
      {required int movieId}) async {
    try {
      final json = await _apiService.getMovieDetail(movieId: movieId);
      print(json);
      final movieDetail = MovieDetail.fromJson(json);
      return Right(movieDetail);
    } catch (e) {
      print(e.toString());
      return Left(Failure(e.toString()));
    }
  }
}
