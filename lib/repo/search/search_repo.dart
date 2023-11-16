import 'package:dartz/dartz.dart';
import 'package:movie_db_app/data/models/failure.dart';
import 'package:movie_db_app/data/models/genre_model.dart';
import 'package:movie_db_app/data/models/search_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, Search>> search({required String keyword, required int pageNumber});
  Future<Either<Failure, Genre>> getAllGenre();
}
