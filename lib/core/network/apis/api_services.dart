import 'dart:io';
import 'package:dio/dio.dart';
import 'package:my_code_structure/core/network/apis/api_logger.dart';
import 'package:dartz/dartz.dart';

class NetworkError {
  final String message;
  final int? statusCode;

  NetworkError(this.message, this.statusCode);

  @override
  String toString() {
    // Helpful for debugging
    return 'NetworkError(message: $message, statusCode: $statusCode)';
  }
}

class ApiServices {
  final Dio _dio;
  final String baseUrl;

  ApiServices({required this.baseUrl, String? initialAuthToken})
    : _dio = Dio() {
    _dio.options.baseUrl = baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.add(ApiLogger());
    if (initialAuthToken != null && initialAuthToken.isNotEmpty) {
      setAuthToken(initialAuthToken);
    }
  }

  NetworkError _handleDioError(DioException e) {
    String errorMessage = e.message ?? 'An unexpected error occurred';
    final responseData = e.response?.data;

    if (responseData is Map<String, dynamic>) {
      errorMessage =
          responseData['error']?.toString() ??
          responseData['detail']?.toString() ??
          e.message ??
          'An unexpected error occurred';
    } else if (responseData is String && responseData.isNotEmpty) {
      errorMessage = responseData;
    }

    return NetworkError(errorMessage, e.response?.statusCode);
  }

  // Set auth token
  void setAuthToken(String? token) {
    if (token != null && token.isNotEmpty) {
      // token = "88d214e1-7400-4e11-8628-315cfd17a1ee";
      _dio.options.headers['Authorization'] = 'Token $token';
    } else {
      clearAuthToken();
    }
  }

  // Clear auth token
  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  // Get with query parameters
  Future<Either<NetworkError, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(NetworkError(e.toString(), null));
    }
  }

  // Post with JSON data
  Future<Either<NetworkError, dynamic>> postJson(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(contentType: Headers.jsonContentType),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(NetworkError(e.toString(), null));
    }
  }

  // Post with form data (including file uploads)
  Future<Either<NetworkError, dynamic>> postFormData(
    String path, {
    required Map<String, dynamic> formData,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final formDataObj = FormData();

      formData.forEach((key, value) {
        if (value is File) {
          // Handle file uploads
          formDataObj.files.add(
            MapEntry(
              key,
              MultipartFile.fromFileSync(
                value.path,
                filename: value.path.split('/').last,
              ),
            ),
          );
        } else if (value is List<File>) {
          // Handle multiple file uploads for the same field
          for (var file in value) {
            formDataObj.files.add(
              MapEntry(
                key,
                MultipartFile.fromFileSync(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              ),
            );
          }
        } else {
          // Handle regular form fields
          formDataObj.fields.add(MapEntry(key, value.toString()));
        }
      });

      final Response response = await _dio.post(
        path,
        data: formDataObj,
        queryParameters: queryParameters,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          sendTimeout: const Duration(minutes: 5),
          receiveTimeout: const Duration(minutes: 5),
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(NetworkError(e.toString(), null));
    }
  }

  Future<Either<NetworkError, dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(contentType: Headers.jsonContentType),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(NetworkError(e.toString(), null));
    }
  }

  Future<Either<NetworkError, dynamic>> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(NetworkError(e.toString(), null));
    }
  }

  // Patch with form data (including file uploads)
  Future<Either<NetworkError, dynamic>> patchFormData(
    String path, {
    required Map<String, dynamic> formData,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final formDataObj = FormData();

      formData.forEach((key, value) {
        if (value is File) {
          // Handle file uploads
          formDataObj.files.add(
            MapEntry(
              key,
              MultipartFile.fromFileSync(
                value.path,
                filename: value.path.split('/').last,
              ),
            ),
          );
        } else if (value is List<File>) {
          // Handle multiple file uploads for the same field
          for (var file in value) {
            formDataObj.files.add(
              MapEntry(
                key,
                MultipartFile.fromFileSync(
                  file.path,
                  filename: file.path.split('/').last,
                ),
              ),
            );
          }
        } else {
          // Handle regular form fields
          formDataObj.fields.add(MapEntry(key, value.toString()));
        }
      });

      final Response response = await _dio.patch(
        path,
        data: formDataObj,
        queryParameters: queryParameters,
        options: Options(contentType: Headers.multipartFormDataContentType),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleDioError(e));
    } catch (e) {
      return Left(NetworkError(e.toString(), null));
    }
  }
}
