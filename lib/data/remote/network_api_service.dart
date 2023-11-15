import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movie_db_app/data/models/upcoming_movies_model.dart';
import 'package:movie_db_app/data/remote/api_endpoints.dart';
import 'package:movie_db_app/data/remote/api_exception.dart';
import 'package:movie_db_app/data/remote/dio_client.dart';
import '../../data/remote/base_api_service.dart';

class NetworkApiService extends BaseApiService {
  final Dio _dio = Dio();
  late DioClient _dioClient;

  NetworkApiService() {
    _dioClient = DioClient(_dio);
  }

  @override
  Future getUpcomingMovies({required int pageNumber}) async {
    try {
      final response = await _dioClient.get(ApiEndPoints().upcomingMovies,
          queryParameters: {'page': pageNumber});
      return returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
  }

  @override
  Future getMovieDetail({required int movieId}) async {
    try {
      print('${ApiEndPoints().movieDetail}/$movieId');
      final response = await _dioClient.get(
        '/${ApiEndPoints().movieDetail}/$movieId',
      );
      return returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
  }

  @override
  Future getMovieImages({required int movieId}) async {
    try {
      print('${ApiEndPoints().movieDetail}/$movieId/images');
      final response = await _dioClient.get(
        '/${ApiEndPoints().movieDetail}/$movieId/images',
      );
      return returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
  }

  @override
  Future getMovieTrailer({required int movieId}) async {
    try {
      print('${ApiEndPoints().movieDetail}/$movieId/videos');
      final response = await _dioClient.get(
        '/${ApiEndPoints().movieDetail}/$movieId/videos',
      );
      return returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
  }

  @override
  Future getAllGenre() async {
    try {
      final response = await _dioClient.get(
        ApiEndPoints().genre,
      );
      return returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
  }

  @override
  Future search({required String keyword}) async {
    try {
      
      final response = await _dioClient.get(
        ApiEndPoints().searchMovies,
        queryParameters: {
          'query' : keyword
        }
      );
      return returnResponse(response);
    } on DioException catch (e) {
      if (e.response != null) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
  }

  dynamic returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        final responseJson = response.data;
        return responseJson;
      case 400:
      case 401:
      case 403:
      case 404:
      case 500:
      default:
        throw Exception(
            'Error occurred with status code : ${response.statusCode}');
    }
  }
  
  
}
