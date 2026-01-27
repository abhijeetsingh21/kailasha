import 'dart:async';

class ApiResult {
  static final ApiResult _instance = ApiResult._internal();
  final _statusCodeController = StreamController<int>.broadcast();

  ApiResult._internal();

  factory ApiResult() => _instance;

  void setStatusCode(int? statusCode) {
    if (!_statusCodeController.isClosed) {
      _statusCodeController.add(statusCode ?? 0);
    }
  }

  Stream<int> get statusCodeStream => _statusCodeController.stream;

  void closeStream() {
    _statusCodeController.close();
  }
}
