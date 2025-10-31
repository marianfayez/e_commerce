import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/resources/constants_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@lazySingleton
class ApiManager {
  late final Dio _dio;

  ApiManager() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    // Optionally add an interceptor for additional functionality
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      responseBody: true,
      requestBody: true,
      request: true,
    ));
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) {
        handler.next(error);
      },
    ));
  }

  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postData(
    String endPoint, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.post(
        endPoint,
        data: data,
        options: Options(headers: headers),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;

      String errorMessage = 'Unknown error occurred';

      if (errorData is Map<String, dynamic>) {
        if (errorData.containsKey('message') &&
            errorData['message'] is String) {
          errorMessage = errorData['message'];
        }

        // Check if there's a nested 'errors' object
        if (errorData.containsKey('errors') && errorData['errors'] is Map) {
          final nested = errorData['errors'];
          if (nested is Map<String, dynamic> && nested.containsKey('msg')) {
            errorMessage =
                nested['msg']; // 👈 Here is your useful error message
          }
        }
      }

      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: errorMessage,
      );
    }
  }

  Future<Response> deleteRequest(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      return await _dio.delete(
        endPoint,
        data: queryParameters,
        options: Options(headers: headers),
      );
    } on DioError catch (e) {
      // Handle DioError here by throwing or logging
      throw Exception('Failed to DELETE: $e');
    }
  }

  Future<Response> putData(
    String endPoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(
        endPoint,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
        ),
      );
    } on DioException catch (e) {
      final errorData = e.response?.data;
      String errorMessage = 'Unknown error occurred';

      if (errorData is Map<String, dynamic>) {
        if (errorData.containsKey('message') &&
            errorData['message'] is String) {
          errorMessage = errorData['message'];
        }

        if (errorData.containsKey('errors') && errorData['errors'] is Map) {
          final nested = errorData['errors'];
          if (nested is Map<String, dynamic> && nested.containsKey('msg')) {
            errorMessage = nested['msg'];
          }
        }
      }

      throw DioException(
        requestOptions: e.requestOptions,
        response: e.response,
        type: e.type,
        error: errorMessage,
      );
    }
  }
}
