import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:kailasha/core/constants/app_errors.dart';
import 'package:kailasha/core/network/dio/api_exception.dart';
import 'package:kailasha/core/network/dio/api_result.dart';
import 'package:kailasha/core/network/interceptors/auth_interceptor.dart';
import 'package:kailasha/core/network/interceptors/network_interceptor.dart';
import 'package:kailasha/core/network/interceptors/retry_interceptor.dart';
import 'package:kailasha/core/network/retry/connection_failure_handler.dart';
import 'package:kailasha/core/network/retry/retry_condition.dart';
import 'package:kailasha/core/network/retry/retry_manager.dart';
import 'package:kailasha/core/utils/common_enums.dart';


///1. Create default header
///2. Add token if exists
///3. Add other header params if passed
///4. Refresh the token if [_authErrorCode]

typedef JsonMap = Map<String, dynamic>;

extension ApiStatusExtension on ApiStatus {
  bool get isLoading {
    return this == ApiStatus.loading;
  }
}

@LazySingleton()
class DioUtil {
  static final DioUtil _instance = DioUtil.internal();
  static late Dio _dio;
  static ApiResult apiResult = ApiResult();

  DioUtil.internal() {
    _dio = Dio();

    final retryInterceptor = RetryOnConnectionChangeInterceptor(
      retryCondition: ConnectionRetryCondition(),
      retryManager: RetryManager(_dio),
      failureHandler: DefaultConnectionFailureHandler(),
      dio: _dio,
    );

    final authInterceptor = AuthInterceptor();
    final networkInterceptor = NetworkInterceptor();

    // Now add interceptors
    _dio.interceptors.addAll([
      networkInterceptor,
      authInterceptor,
      retryInterceptor,
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (kDebugMode) {
            if (options.data is FormData) {
              FormData d = options.data;
              d.fields.forEach(
                ((field) => debugPrint('Fields: ${field.key}: ${field.value}')),
              );
              for (var field in d.files) {
                debugPrint(
                  'Files: ${field.key}: ${field.value.filename} ${field.value.contentType?.mimeType}',
                );
              }
            }
          }
          return handler.next(options);
        },
      ),
      if (kDebugMode)
        LogInterceptor(
          logPrint: _log,
          request: kDebugMode,
          error: kDebugMode,
          responseHeader: kDebugMode,
          requestBody: kDebugMode,
          requestHeader: kDebugMode,
          responseBody: kDebugMode,
        ),
    ]);
  }

  void _log(Object object) {
    log('$object');
  }

  factory DioUtil() => _instance;

  final CancelToken _cancelToken = CancelToken();

  Future<dynamic> get(
    String url, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      Response response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw await _handleDioException(error: e, path: url);
    }
  }

  Future<dynamic> post(
    String url, {
    JsonMap? body,
    FormData? formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Function(int, int)? onSendProgress,
  }) async {
    try {
      Response response = await _dio.post(
        url,
        data: formData ?? body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
        onSendProgress: onSendProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw await _handleDioException(error: e, path: url);
    }
  }

  Future<dynamic> fetch(
    RequestOptions requestOptions, {
    Map<String, dynamic>? headers,
    Function(int, int)? onSendProgress,
  }) async {
    try {
      if (headers != null && headers.isNotEmpty) {
        final newHeaders = Map<String, dynamic>.from(requestOptions.headers);
        newHeaders.addAll(headers);
        requestOptions = requestOptions.copyWith(headers: newHeaders);
      }

      final response = await _dio.fetch<dynamic>(requestOptions);
      return response.data;
    } on DioException catch (e) {
      throw await _handleDioException(error: e, path: requestOptions.path);
    }
  }

  Future<dynamic> put(
    String url, {
    JsonMap? body,
    FormData? formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Function(int, int)? onSendProgress,
  }) async {
    try {
      Response response = await _dio.put(
        url,
        data: formData ?? body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
        onSendProgress: onSendProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw await _handleDioException(error: e, path: url);
    }
  }

  Future<dynamic> patch(
    String url, {
    JsonMap? body,
    FormData? formData,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
    Function(int, int)? onSendProgress,
  }) async {
    try {
      Response response = await _dio.patch(
        url,
        data: formData ?? body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
        onSendProgress: onSendProgress,
      );
      return response.data;
    } on DioException catch (e) {
      throw await _handleDioException(error: e, path: url);
    }
  }

  Future delete(
    String url, {
    JsonMap? body,
    Map<String, dynamic>? header,
  }) async {
    try {
      url = url;
      Response response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: header),
        cancelToken: _cancelToken,
      );
      return response.data;
    } on DioException catch (e) {
      throw await _handleDioException(error: e, path: url);
    }
  }

  Future<ApiException> _handleDioException({
    required DioException error,
    required String path,
  }) async {
    final method = error.requestOptions.method;
    final response = error.response;
    final statusCode = response?.statusCode;
    final data = response?.data;
    apiResult.setStatusCode(response?.statusCode);
    final message = getMessage(data);

    if (error.error == AppErrors.noInternet) {
      throw ApiException(
        info: 'Received server error $statusCode while $method data',
        response: data,
        errorMessage:
            'No internet connection. Please check your network and try again.',
        path: path,
        statusCode: 500,
        method: method,
      );
    }

    throw ApiException(
      errorMessage: message,
      path: path,
      info: 'Received server error $statusCode while $method data',
      response: data,
      statusCode: statusCode,
      method: method,
    );
  }

  String getMessage(dynamic data) {
    final message = data["message"] ?? data["error"];
    if (message != null) {
      if (message.runtimeType == String) {
        return message;
      } else {
        return message.toString();
      }
    }

    return AppErrors.unknownErrorDetails;
  }
}
