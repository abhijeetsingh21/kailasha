// retry_manager.dart
import 'dart:developer';

import 'package:dio/dio.dart';

class RetryManager {
  final Dio dio;

  final List<(DioException, ErrorInterceptorHandler)> _failedRequests = [];

  RetryManager(this.dio);

  void addFailedRequest(DioException e, ErrorInterceptorHandler handler) {
    _failedRequests.add((e, handler));
  }

  Future<void> retryAll() async {
    for (final (error, handler) in _failedRequests) {
      try {
        final response = await dio.fetch(error.requestOptions);
        handler.resolve(response);
      } on DioException catch (e) {
        log('Retry failed: ${e.message}');
      } catch (e) {
        log(e.toString());
      }
    }
    _failedRequests.clear();
  }

  bool get hasFailedRequests => _failedRequests.isNotEmpty;
}
