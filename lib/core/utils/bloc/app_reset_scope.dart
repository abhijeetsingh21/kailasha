import 'package:flutter/material.dart';

class AppResetScope extends StatefulWidget {
  final Widget child;
  final GlobalKey<AppResetScopeState> appResetKey;
  const AppResetScope({
    super.key,
    required this.child,
    required this.appResetKey,
  });

  static AppResetScopeState of(BuildContext context) =>
      context.findAncestorStateOfType<AppResetScopeState>()!;

  @override
  State<AppResetScope> createState() => AppResetScopeState();
}

class AppResetScopeState extends State<AppResetScope> {
  Key _key = UniqueKey();

  void resetApp() {
    setState(() {
      _key = UniqueKey(); // <— Forces complete rebuild of RootBlocInjection
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: _key, child: widget.child);
  }
}
