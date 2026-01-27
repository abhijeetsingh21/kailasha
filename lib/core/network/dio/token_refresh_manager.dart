import 'dart:async';

class TokenRefreshManager {
  static bool _isRefreshing = false;
  static Completer<bool>? _refreshCompleter;

  static bool get isRefreshing => _isRefreshing;

  static Future<bool> waitForRefresh() async {
    return _refreshCompleter?.future ?? Future.value(false);
  }

  static void startRefresh() {
    _isRefreshing = true;
    _refreshCompleter = Completer<bool>();
  }

  static void completeRefresh(bool success) {
    _isRefreshing = false;
    _refreshCompleter?.complete(success);
    _refreshCompleter = null;
  }
}
