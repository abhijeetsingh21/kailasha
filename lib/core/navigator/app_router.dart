import 'package:auto_route/auto_route.dart';
import 'package:kailasha/common/route_component.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    autoRouteComponent(page: SplashRoute.page, initial: true),

    autoRouteComponent(page: HomeRoute.page),

    autoRouteComponent(
      page: DashBoardRoute.page,
      children: [
        autoRouteComponent(page: SchoolsRoute.page, initial: true),
        autoRouteComponent(page: AdminProfileRoute.page),
      ],
    ),

    autoRouteComponent(page: SignInForm.page),

    autoRouteComponent(page: SchoolsRoute.page),
    autoRouteComponent(page: SignUpRoute.page),
    autoRouteComponent(page: ExperimentRoute.page),
    autoRouteComponent(page: ExperimentDetailsRoute.page),
    autoRouteComponent(page: AddExperimentRoute.page),
    autoRouteComponent(page: SchoolSignupRoute.page),
    autoRouteComponent(page: ChatRoute.page),
    autoRouteComponent(page: ForgotPasswordFlowRoute.page),
  ];
}
