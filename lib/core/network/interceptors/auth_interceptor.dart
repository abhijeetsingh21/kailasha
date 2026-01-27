import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:kailasha/core/constants/api_constant.dart';
import 'package:kailasha/core/preference/preference_helper.dart';

///1. Create default header
///2. Add token if exists
///3. Add other header params if passed
///4. Refresh the token if [_authErrorCode]
class AuthInterceptor extends QueuedInterceptor {
  static const int _authErrorCode = 401;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final headers = await _createHeader(options.headers);
      options = options.copyWith(
        headers: headers,
        baseUrl: ApiConstant.baseUrl,
        sendTimeout: kIsWeb ? null : const Duration(milliseconds: 30000),
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
      );
      handler.next(options);
    } catch (e) {
      debugPrint('AuthInterceptor error: $e');
      _sendAuthError(handler, options);
    }
  }

  Future<Map<String, dynamic>> _createHeader(
    Map<String, dynamic>? headers,
  ) async {
    Map<String, dynamic> tempHeader = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
      'ngrok-skip-browser-warning': '1',
    };

    if (headers != null) tempHeader.addAll(headers);

    final accessToken = await PreferenceHelper.getAccessToken();

    if (accessToken?.isNotEmpty == true) {
      tempHeader['authorization'] = 'Bearer $accessToken';
    }

    return tempHeader;
  }

  void _sendAuthError(
    RequestInterceptorHandler handler,
    RequestOptions options,
  ) {
    handler.reject(
      DioException(
        requestOptions: options,
        response: Response(requestOptions: options, statusCode: _authErrorCode),
        type: DioExceptionType.badResponse,
      ),
    );
  }
}
