import 'package:dartz/dartz.dart';
import 'package:movie_db_app/data/models/failure.dart';
import 'package:movie_db_app/data/models/genre_model.dart';
import 'package:movie_db_app/data/models/search_model.dart';
import 'package:movie_db_app/data/remote/base_api_service.dart';
import 'package:movie_db_app/data/remote/network_api_service.dart';
import 'package:movie_db_app/repo/search/search_repo.dart';

class SearchRepoImpl extends SearchRepo{

  final BaseApiService _apiService = NetworkApiService();

  @override
  Future<Either<Failure, Search>> search({required String keyword, required int pageNumber} ) async {
    try { 
      final json = await _apiService.search(keyword: keyword, pageNumber: pageNumber);
      print(json);
      final search = Search.fromJson(json);
      return Right(search);
    } catch (e) {
      print(e.toString());
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Genre>> getAllGenre() async {
    try { 
      final json = await _apiService.getAllGenre();
      print(json);
      final search = Genre.fromJson(json);
      return Right(search);
    } catch (e) {
      print(e.toString());
      return Left(Failure(e.toString()));
    }
  }
  
}