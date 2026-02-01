// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:kailasha/pages/auth/view/forget_password_page.dart' as _i6;
import 'package:kailasha/pages/auth/view/login_page.dart' as _i10;
import 'package:kailasha/pages/auth/view/school_signup_page.dart' as _i9;
import 'package:kailasha/pages/auth/view/sign_up_page.dart' as _i11;
import 'package:kailasha/pages/chat/view/chat_page.dart' as _i2;
import 'package:kailasha/pages/dashboard/view/dashboard_page.dart' as _i3;
import 'package:kailasha/pages/experiments/view/add_experiment_page.dart'
    as _i1;
import 'package:kailasha/pages/experiments/view/experiment_details_page.dart'
    as _i4;
import 'package:kailasha/pages/experiments/view/experiment_page.dart' as _i5;
import 'package:kailasha/pages/home/view/home_page.dart' as _i7;
import 'package:kailasha/pages/onboarding/no_internet_page.dart' as _i8;
import 'package:kailasha/pages/onboarding/splash_page.dart' as _i12;

/// generated route for
/// [_i1.AddExperimentPage]
class AddExperimentRoute extends _i13.PageRouteInfo<void> {
  const AddExperimentRoute({List<_i13.PageRouteInfo>? children})
    : super(AddExperimentRoute.name, initialChildren: children);

  static const String name = 'AddExperimentRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddExperimentPage();
    },
  );
}

/// generated route for
/// [_i2.ChatPage]
class ChatRoute extends _i13.PageRouteInfo<void> {
  const ChatRoute({List<_i13.PageRouteInfo>? children})
    : super(ChatRoute.name, initialChildren: children);

  static const String name = 'ChatRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i2.ChatPage();
    },
  );
}

/// generated route for
/// [_i3.DashBoardPage]
class DashBoardRoute extends _i13.PageRouteInfo<void> {
  const DashBoardRoute({List<_i13.PageRouteInfo>? children})
    : super(DashBoardRoute.name, initialChildren: children);

  static const String name = 'DashBoardRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashBoardPage();
    },
  );
}

/// generated route for
/// [_i4.ExperimentDetailsPage]
class ExperimentDetailsRoute
    extends _i13.PageRouteInfo<ExperimentDetailsRouteArgs> {
  ExperimentDetailsRoute({
    _i14.Key? key,
    required _i4.ExperimentDetailsPageParams params,
    List<_i13.PageRouteInfo>? children,
  }) : super(
         ExperimentDetailsRoute.name,
         args: ExperimentDetailsRouteArgs(key: key, params: params),
         initialChildren: children,
       );

  static const String name = 'ExperimentDetailsRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExperimentDetailsRouteArgs>();
      return _i4.ExperimentDetailsPage(key: args.key, params: args.params);
    },
  );
}

class ExperimentDetailsRouteArgs {
  const ExperimentDetailsRouteArgs({this.key, required this.params});

  final _i14.Key? key;

  final _i4.ExperimentDetailsPageParams params;

  @override
  String toString() {
    return 'ExperimentDetailsRouteArgs{key: $key, params: $params}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExperimentDetailsRouteArgs) return false;
    return key == other.key && params == other.params;
  }

  @override
  int get hashCode => key.hashCode ^ params.hashCode;
}

/// generated route for
/// [_i5.ExperimentPage]
class ExperimentRoute extends _i13.PageRouteInfo<void> {
  const ExperimentRoute({List<_i13.PageRouteInfo>? children})
    : super(ExperimentRoute.name, initialChildren: children);

  static const String name = 'ExperimentRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i5.ExperimentPage();
    },
  );
}

/// generated route for
/// [_i6.ForgotPasswordFlowPage]
class ForgotPasswordFlowRoute extends _i13.PageRouteInfo<void> {
  const ForgotPasswordFlowRoute({List<_i13.PageRouteInfo>? children})
    : super(ForgotPasswordFlowRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordFlowRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i6.ForgotPasswordFlowPage();
    },
  );
}

/// generated route for
/// [_i7.HomePage]
class HomeRoute extends _i13.PageRouteInfo<void> {
  const HomeRoute({List<_i13.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i7.HomePage();
    },
  );
}

/// generated route for
/// [_i8.NoInternetPage]
class NoInternetRoute extends _i13.PageRouteInfo<void> {
  const NoInternetRoute({List<_i13.PageRouteInfo>? children})
    : super(NoInternetRoute.name, initialChildren: children);

  static const String name = 'NoInternetRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i8.NoInternetPage();
    },
  );
}

/// generated route for
/// [_i9.SchoolSignupPage]
class SchoolSignupRoute extends _i13.PageRouteInfo<void> {
  const SchoolSignupRoute({List<_i13.PageRouteInfo>? children})
    : super(SchoolSignupRoute.name, initialChildren: children);

  static const String name = 'SchoolSignupRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i9.SchoolSignupPage();
    },
  );
}

/// generated route for
/// [_i10.SignInForm]
class SignInForm extends _i13.PageRouteInfo<void> {
  const SignInForm({List<_i13.PageRouteInfo>? children})
    : super(SignInForm.name, initialChildren: children);

  static const String name = 'SignInForm';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i10.SignInForm();
    },
  );
}

/// generated route for
/// [_i11.SignUpPage]
class SignUpRoute extends _i13.PageRouteInfo<void> {
  const SignUpRoute({List<_i13.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i11.SignUpPage();
    },
  );
}

/// generated route for
/// [_i12.SplashPage]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i13.PageInfo page = _i13.PageInfo(
    name,
    builder: (data) {
      return const _i12.SplashPage();
    },
  );
}
