import 'package:auto_route/auto_route.dart';
import 'package:kailasha/common/route_component.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    autoRouteComponent(page: SplashRoute.page, initial: true),
    // autoRouteComponent(
    //   page: DashBoardRoute.page,
    //   children: [autoRouteComponent(page: HomeRoute.page, initial: true)],
    // ),
    autoRouteComponent(page: NoInternetRoute.page),
    autoRouteComponent(page: HomeRoute.page),
    autoRouteComponent(page: SignInForm.page),
    autoRouteComponent(page: SignUpRoute.page),
    autoRouteComponent(page: ExperimentRoute.page),
    autoRouteComponent(page: ExperimentDetailsRoute.page),
    autoRouteComponent(page: AddExperimentRoute.page),

    autoRouteComponent(page: ChatRoute.page),

    autoRouteComponent(page: ForgotPasswordFlowRoute.page),
  ];
}
