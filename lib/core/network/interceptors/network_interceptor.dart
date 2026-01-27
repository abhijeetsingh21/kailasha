import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:kailasha/core/constants/app_errors.dart';
class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Check connectivity
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: AppErrors.noInternet,
          type: DioExceptionType.unknown,
          message: AppErrors.noInternet,
        ),
      );
    }

    // Extra check: verify actual internet access
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty || result[0].rawAddress.isEmpty) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: AppErrors.noInternet,
            type: DioExceptionType.unknown,
            message: AppErrors.noInternet,
          ),
        );
      }
    } on SocketException {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: AppErrors.noInternet,
          type: DioExceptionType.unknown,
          message: AppErrors.noInternet,
        ),
      );
    }

    return handler.next(options);
  }
}
