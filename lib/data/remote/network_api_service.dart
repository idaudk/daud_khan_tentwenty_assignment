
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

  NetworkApiService(){
    _dioClient = DioClient(_dio);
  }

  // @override
  // Future<List<LoginModel>> loginResponse(
  //     String url, String email, String password) async {
  //   try {
  //     // var testUrl = Uri.http(baseUrl, url);
  //     var uri = Uri.parse(
  //         'https://jsonplaceholder.typicode.com/users'); //TODO will add base URL here
  //     final response = await http.get(uri);
  //     return responseJson(response);
  //   } catch (e) {
  //     if (e is AppException) {
  //       throw FetchDataException(e.toString());
  //     } else if (e is SocketException) {
  //       throw FetchDataException("Socket Exception: ${e.toString()}");
  //     } else {
  //       throw FetchDataException("Something went wrong: ${e.toString()}");
  //     }
  //   }
  // }

  @override
  Future getUpcomingMovies({required int pageNumber}) {
    try {
      final response = _dioClient.get(ApiEndPoints().upcomingMovies, queryParameters: {
        'page' : pageNumber
      });
      return returnResponse(response);
    } catch (e) {
      if (e is AppException) {
        throw FetchDataException(e.toString());
      } else if (e is SocketException) {
        throw FetchDataException("Socket Exception: ${e.toString()}");
      } else {
        throw FetchDataException("Something went wrong: ${e.toString()}");
      }
    }
  }


  dynamic returnResponse(response) {
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
