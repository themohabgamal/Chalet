import 'package:dio/dio.dart';

import '../error/failures.dart';
import '../utils/cache_helper.dart';
import 'api_consumer.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.headers['token'] = CacheHelper.getData('token');
    // dio.options.headers['Authorization'] =
    //     "${CacheHelper.getData('token')}";
    dio.options.baseUrl = "https://chaletspot.vercel.app";

    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: false,
        responseHeader: true,
        responseBody: false,
        error: true,
      ),
    );
  }

  @override
  Future delete(path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future put(path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future post(path,
      {Object? data, Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerFailures(
        'Connection to the server timed out.',
      );

    case DioExceptionType.sendTimeout:
      throw ServerFailures('Send timed out');

    case DioExceptionType.receiveTimeout:
      throw ServerFailures('Receive timed out');

    case DioExceptionType.badCertificate:
      throw ServerFailures('Bad Certificate');

    case DioExceptionType.cancel:
      throw ServerFailures(
        'Request cancelled.',
      );

    case DioExceptionType.connectionError:
      throw ServerFailures(
        'Unable to connect to the server, please make sure you are connected to the internet and try again.',
      );

    case DioExceptionType.unknown:
      throw ServerFailures(
        'An unknown error occurred.',
      );
    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:
          throw ServerFailures(e.response?.data["msg"]);
        case 401:
          throw ServerFailures(e.response?.data["msg"]);
        case 403:
          throw ServerFailures(e.response?.data["msg"]);
        case 404:
          throw ServerFailures(e.response?.data["msg"]);
        case 409:
          throw ServerFailures(e.response?.data["msg"]);
        case 422:
          throw ServerFailures(e.response?.data["msg"]);
        case 504:
          throw ServerFailures(e.response?.data["msg"]);
      }
  }
}
