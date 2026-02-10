// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:kailasha/pages/admin_profile/view/admin_profile_page.dart'
    as _i2;
import 'package:kailasha/pages/auth/view/forget_password_page.dart' as _i7;
import 'package:kailasha/pages/auth/view/login_page.dart' as _i12;
import 'package:kailasha/pages/auth/view/school_signup_page.dart' as _i10;
import 'package:kailasha/pages/auth/view/sign_up_page.dart' as _i13;
import 'package:kailasha/pages/chat/view/chat_page.dart' as _i3;
import 'package:kailasha/pages/dashboard/view/dashboard_page.dart' as _i4;
import 'package:kailasha/pages/admin_profile/view/add_experiment_page.dart'
    as _i1;
import 'package:kailasha/pages/experiments/view/experiment_details_page.dart'
    as _i5;
import 'package:kailasha/pages/experiments/view/experiment_page.dart' as _i6;
import 'package:kailasha/pages/home/view/home_page.dart' as _i8;
import 'package:kailasha/pages/onboarding/no_internet_page.dart' as _i9;
import 'package:kailasha/pages/onboarding/splash_page.dart' as _i14;
import 'package:kailasha/pages/schools/view/schools_page.dart' as _i11;

/// generated route for
/// [_i1.AddExperimentPage]
class AddExperimentRoute extends _i15.PageRouteInfo<void> {
  const AddExperimentRoute({List<_i15.PageRouteInfo>? children})
    : super(AddExperimentRoute.name, initialChildren: children);

  static const String name = 'AddExperimentRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddExperimentPage();
    },
  );
}

/// generated route for
/// [_i2.AdminProfilePage]
class AdminProfileRoute extends _i15.PageRouteInfo<void> {
  const AdminProfileRoute({List<_i15.PageRouteInfo>? children})
    : super(AdminProfileRoute.name, initialChildren: children);

  static const String name = 'AdminProfileRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.AdminProfilePage();
    },
  );
}

/// generated route for
/// [_i3.ChatPage]
class ChatRoute extends _i15.PageRouteInfo<void> {
  const ChatRoute({List<_i15.PageRouteInfo>? children})
    : super(ChatRoute.name, initialChildren: children);

  static const String name = 'ChatRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.ChatPage();
    },
  );
}

/// generated route for
/// [_i4.DashBoardPage]
class DashBoardRoute extends _i15.PageRouteInfo<void> {
  const DashBoardRoute({List<_i15.PageRouteInfo>? children})
    : super(DashBoardRoute.name, initialChildren: children);

  static const String name = 'DashBoardRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.DashBoardPage();
    },
  );
}

/// generated route for
/// [_i5.ExperimentDetailsPage]
class ExperimentDetailsRoute
    extends _i15.PageRouteInfo<ExperimentDetailsRouteArgs> {
  ExperimentDetailsRoute({
    _i16.Key? key,
    required _i5.ExperimentDetailsPageParams params,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ExperimentDetailsRoute.name,
         args: ExperimentDetailsRouteArgs(key: key, params: params),
         initialChildren: children,
       );

  static const String name = 'ExperimentDetailsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExperimentDetailsRouteArgs>();
      return _i5.ExperimentDetailsPage(key: args.key, params: args.params);
    },
  );
}

class ExperimentDetailsRouteArgs {
  const ExperimentDetailsRouteArgs({this.key, required this.params});

  final _i16.Key? key;

  final _i5.ExperimentDetailsPageParams params;

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
/// [_i6.ExperimentPage]
class ExperimentRoute extends _i15.PageRouteInfo<ExperimentRouteArgs> {
  ExperimentRoute({
    _i16.Key? key,
    required _i6.ExperimentPageParams parms,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ExperimentRoute.name,
         args: ExperimentRouteArgs(key: key, parms: parms),
         initialChildren: children,
       );

  static const String name = 'ExperimentRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ExperimentRouteArgs>();
      return _i6.ExperimentPage(key: args.key, parms: args.parms);
    },
  );
}

class ExperimentRouteArgs {
  const ExperimentRouteArgs({this.key, required this.parms});

  final _i16.Key? key;

  final _i6.ExperimentPageParams parms;

  @override
  String toString() {
    return 'ExperimentRouteArgs{key: $key, parms: $parms}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ExperimentRouteArgs) return false;
    return key == other.key && parms == other.parms;
  }

  @override
  int get hashCode => key.hashCode ^ parms.hashCode;
}

/// generated route for
/// [_i7.ForgotPasswordFlowPage]
class ForgotPasswordFlowRoute extends _i15.PageRouteInfo<void> {
  const ForgotPasswordFlowRoute({List<_i15.PageRouteInfo>? children})
    : super(ForgotPasswordFlowRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordFlowRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.ForgotPasswordFlowPage();
    },
  );
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i15.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i16.Key? key,
    required _i8.HomePageParams params,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, params: params),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>();
      return _i8.HomePage(key: args.key, params: args.params);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, required this.params});

  final _i16.Key? key;

  final _i8.HomePageParams params;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, params: $params}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HomeRouteArgs) return false;
    return key == other.key && params == other.params;
  }

  @override
  int get hashCode => key.hashCode ^ params.hashCode;
}

/// generated route for
/// [_i9.NoInternetPage]
class NoInternetRoute extends _i15.PageRouteInfo<void> {
  const NoInternetRoute({List<_i15.PageRouteInfo>? children})
    : super(NoInternetRoute.name, initialChildren: children);

  static const String name = 'NoInternetRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i9.NoInternetPage();
    },
  );
}

/// generated route for
/// [_i10.SchoolSignupPage]
class SchoolSignupRoute extends _i15.PageRouteInfo<void> {
  const SchoolSignupRoute({List<_i15.PageRouteInfo>? children})
    : super(SchoolSignupRoute.name, initialChildren: children);

  static const String name = 'SchoolSignupRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.SchoolSignupPage();
    },
  );
}

/// generated route for
/// [_i11.SchoolsPage]
class SchoolsRoute extends _i15.PageRouteInfo<void> {
  const SchoolsRoute({List<_i15.PageRouteInfo>? children})
    : super(SchoolsRoute.name, initialChildren: children);

  static const String name = 'SchoolsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i11.SchoolsPage();
    },
  );
}

/// generated route for
/// [_i12.SignInForm]
class SignInForm extends _i15.PageRouteInfo<void> {
  const SignInForm({List<_i15.PageRouteInfo>? children})
    : super(SignInForm.name, initialChildren: children);

  static const String name = 'SignInForm';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SignInForm();
    },
  );
}

/// generated route for
/// [_i13.SignUpPage]
class SignUpRoute extends _i15.PageRouteInfo<void> {
  const SignUpRoute({List<_i15.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.SignUpPage();
    },
  );
}

/// generated route for
/// [_i14.SplashPage]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.SplashPage();
    },
  );
}
