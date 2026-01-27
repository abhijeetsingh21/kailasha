import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

AutoRoute autoRouteComponent({
  required PageInfo page,
  bool? initial,
  RouteTransitionsBuilder? transition,
  List<AutoRoute>? children,
  bool maintainState = true,
}) {
  return CustomRoute(
    page: page,
    duration: Duration(milliseconds: 300),
    transitionsBuilder: transition ?? _slideTransition,
    initial: initial ?? false,
    children: children, 
    maintainState: maintainState,
  );
}

Widget _slideTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return SlideTransition(
    position: Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(animation),
    child: child,
  );
}
