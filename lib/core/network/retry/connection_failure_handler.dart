import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:kailasha/core/constants/global_keys.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
/// Interface for handling connection failures
abstract class ConnectionFailureHandler {
  Future<void> handleNoInternet({
    required bool isServerDown,
    required Future<void> Function() onRetry,
  });
}

/// Default implementation of [ConnectionFailureHandler]
class DefaultConnectionFailureHandler implements ConnectionFailureHandler {
  @override
  Future<void> handleNoInternet({
    required bool isServerDown,
    required Future<void> Function() onRetry,
  }) async {
    final (currentPath, _) = getCurrentRouteAndArgs(GlobalKeys.navigatorKey);

    if (currentPath == NoInternetRoute.name) return;

    final ctx = GlobalKeys.navigatorKey.currentContext;
    if (ctx == null) return;


    AutoRouter.of(ctx).push(
      NoInternetRoute(),

    );
  }
}

/// Utility to extract current route and arguments
(String?, Object?) getCurrentRouteAndArgs(
  GlobalKey<NavigatorState> navigatorKey,
) {
  String? currentPath;
  Object? args;
  navigatorKey.currentState?.popUntil((route) {
    currentPath = route.settings.name;
    args = route.settings.arguments;
    return true;
  });
  return (currentPath, args);
}
