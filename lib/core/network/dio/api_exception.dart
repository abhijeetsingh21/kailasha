class ApiException implements Exception {
  final String info;
  final String path;
  final int? statusCode;
  final String? method;
  final String? userId;
  final String? errorMessage;
  final dynamic response;

  ApiException({
    required this.info,
    required this.path,
    this.userId,
    this.method,
    this.statusCode,
    this.response,
    this.errorMessage,
  });

  /// Returns the main error message, falling back to [info] if [errorMessage] is null.
  String get message => errorMessage ?? info;

  /// Create a copy of this exception with updated values.
  ApiException copyWith({
    String? info,
    String? path,
    int? statusCode,
    String? method,
    String? userId,
    String? errorMessage,
    dynamic response,
  }) {
    return ApiException(
      info: info ?? this.info,
      path: path ?? this.path,
      statusCode: statusCode ?? this.statusCode,
      method: method ?? this.method,
      userId: userId ?? this.userId,
      errorMessage: errorMessage ?? this.errorMessage,
      response: response ?? this.response,
    );
  }

  @override
  String toString() {
    final shortResponse = _shortenResponse(response);
    return 'ApiException('
        'message: $message, '
        'path: $path, '
        'statusCode: $statusCode, '
        'method: $method, '
        'userId: $userId, '
        'response: $shortResponse)';
  }

  /// Shortens long response strings for cleaner logs.
  String _shortenResponse(dynamic resp) {
    if (resp == null) return 'null';
    if (resp is String && resp.length > 150) {
      return '${resp.substring(0, 150)}...';
    }
    return resp.toString();
  }
}
