import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kailasha/core/navigator/app_router.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_theme.dart';
import 'package:kailasha/core/utils/bloc/root_bloc_injection.dart';

final appRouter = AppRouter();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: ScreenUtilInit(
        designSize: Size(size.width, size.height),
        builder: (BuildContext context, Widget? child) {
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return OrientationBuilder(
                builder: (context, orientation) {
                  AppScreenUtil().init(constraints, orientation);
                  return RootBlocInjection(
                    child: MaterialApp.router(
                      title: 'Zembora Driver',
                      theme: AppTheme.lightTheme,
                      darkTheme: AppTheme.lightTheme,
                      routeInformationParser: appRouter.defaultRouteParser(),
                      routerDelegate: appRouter.delegate(
                        navigatorObservers: () => [],
                      ),
                      debugShowCheckedModeBanner: false,

                      supportedLocales: const [Locale('en'), Locale('pt')],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
