// retry_condition.dart
import 'package:dio/dio.dart';

abstract class RetryCondition {
  bool shouldRetry(DioException e);
}

class ConnectionRetryCondition implements RetryCondition {
  @override
  bool shouldRetry(DioException e) =>
      e.type == DioExceptionType.connectionError ||
      e.type == DioExceptionType.connectionTimeout;
}
