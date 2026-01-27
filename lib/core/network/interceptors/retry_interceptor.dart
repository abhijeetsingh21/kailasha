import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/core/constants/api_constant.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/network/dio/token_refresh_manager.dart';
import 'package:kailasha/core/network/retry/connection_failure_handler.dart';
import 'package:kailasha/core/network/retry/retry_condition.dart';
import 'package:kailasha/core/network/retry/retry_manager.dart';
import 'package:kailasha/core/preference/preference.dart';
import 'package:kailasha/core/preference/preference_helper.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final RetryCondition retryCondition;
  final RetryManager retryManager;
  final ConnectionFailureHandler failureHandler;
  final Dio dio;

  RetryOnConnectionChangeInterceptor({
    required this.retryCondition,
    required this.retryManager,
    required this.failureHandler,
    required this.dio,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 403) {
      _logoutAndRedirect();
      return;
    }

    if (statusCode == 401) {
      try {
        // If refresh already running, wait for it
        if (TokenRefreshManager.isRefreshing) {
          final success = await TokenRefreshManager.waitForRefresh();
          if (success) {
            final newToken = await PreferenceHelper.getAccessToken();
            err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
            final response = await dio.fetch(err.requestOptions);
            return handler.resolve(response);
          } else {
            _logoutAndRedirect();
            return;
          }
        }

        // Start refresh
        TokenRefreshManager.startRefresh();

        final success = await _tryRefreshToken();
        TokenRefreshManager.completeRefresh(success);

        if (success) {
          final newToken = await PreferenceHelper.getAccessToken();
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } else {
          _logoutAndRedirect();
          return;
        }
      } catch (e) {
        TokenRefreshManager.completeRefresh(false);
        _logoutAndRedirect();
        return;
      }
    }

    return handler.next(err);
  }

  Future<bool> _tryRefreshToken() async {
    try {
      final refreshToken = await PreferenceHelper.getRefreshToken();
      final deviceId = await getDeviceId();

      if (refreshToken == null || deviceId == null) return false;

      final response = await dio.post(
        ApiConstant.refreshTokenUrl,
        data: {"refreshToken": refreshToken, "deviceId": deviceId},
      );

      if (response.statusCode == 200) {
        await PreferenceHelper.setAccessToken(response.data['accessToken']);
        await PreferenceHelper.setRefreshToken(response.data['refreshToken']);
        return true;
      }
    } catch (e) {
      log("Refresh token failed: $e");
    }
    return false;
  }

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id; // Android hardware ID (may change after reset)
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor; // IDFV, resets if app uninstalled
    }
    return null;
  }

  Future<void> _logoutAndRedirect() async {
    final currentRouteName = appRouter.current.name; // AutoRoute way

    if (currentRouteName != SignInForm.name) {
      await PreferenceHelper.clearAllPreferences();
      await Preferences().init();

      // Clear navigation stack and redirect to SignIn
      appRouter.replaceAll([const SignInForm()]);
    }
  }
}
