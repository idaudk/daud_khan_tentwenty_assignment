import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/data/remote/network_api_service.dart';
import 'package:movie_db_app/repo/movies/movies_repo.dart';

import '../../data/remote/base_api_service.dart';

class MoviesRepoImpl extends MoviesRepo{

  final BaseApiService _apiService = NetworkApiService();


  @override
  Future<dynamic> getUpcomingMovies({required int pageNumber}) async {
    try {
      final response = _apiService.getUpcomingMovies(pageNumber: pageNumber);
      print(response);
    } catch (e) {
      rethrow;
    }
  }

}