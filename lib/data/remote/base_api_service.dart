import 'package:movie_db_app/data/models/upcoming_movies_model.dart';

abstract class BaseApiService {
  static String baseUrl = "https://api.themoviedb.org/3";
  static String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
  static String trailerBaseUrl = "https://www.youtube.com/watch?v=";

  Future<dynamic> getUpcomingMovies({required int pageNumber});
  Future<dynamic> getMovieDetail({required int movieId});
  Future<dynamic> getMovieImages({required int movieId});
  Future<dynamic> getMovieTrailer({required int movieId});
  Future<dynamic> search({required String keyword, required int pageNumber });
  Future<dynamic> getAllGenre();
}
