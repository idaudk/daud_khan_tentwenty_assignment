import 'package:dio/dio.dart';
import 'package:movie_db_app/data/remote/api_endpoints.dart';
import '../../data/remote/base_api_service.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String ACCESS_TOKEN = "x-access-token";
const String DEFAULT_LANGUAGE = "language";
const String AUTHORIZATION = "Authorization";
const String ACCESS_TOKEN_KEY =
    "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMDFkYjE3NGJmOWVlZGE4ZDA4NDA3N2JmMGMwNTE5MyIsInN1YiI6IjY1NTM1NDA5MDgxNmM3MDBhYmJiYmQ0OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.7lV11PTZLfiKZ80Tiub4-K3nL6pMofHlS6BHCNdTXuw";

class DioClient {
// dio instance
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = BaseApiService.baseUrl
      ..options.connectTimeout =
          const Duration(milliseconds: ApiEndPoints.receiveTimeout)
      ..options.receiveTimeout =
          const Duration(milliseconds: ApiEndPoints.receiveTimeout)
      ..options.responseType = ResponseType.json
      ..options.headers = {
        ACCEPT: APPLICATION_JSON,
        AUTHORIZATION: ACCESS_TOKEN_KEY,
      };
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    print("$url API Endpoint");

    final Response response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    print("$url API Endpoint");
    final Response response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  // Put:-----------------------------------------------------------------------
  Future<dynamic> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    print("$url API Endpoint");

    final Response response = await _dio.put(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
    return response;
  }

  // Delete:--------------------------------------------------------------------
  Future<dynamic> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    print("$url API Endpoint");

    final Response response = await _dio.delete(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response;
  }
}
