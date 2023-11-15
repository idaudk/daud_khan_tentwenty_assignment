import 'package:movie_db_app/data/models/upcoming_movies_model.dart';

abstract class BaseApiService {
  static String baseUrl = "https://api.themoviedb.org/3";
  static String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

  Future<dynamic> getUpcomingMovies({required int pageNumber});
  Future<dynamic> getMovieDetail({required int movieId});
}
