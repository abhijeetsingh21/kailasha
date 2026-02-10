import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/image_loader.dart';
import 'package:kailasha/core/constants/app_images.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';
import 'package:kailasha/pages/home/view/home_page.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  late AuthCubit authCubit;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 0.7),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();

    authCubit = context.read<AuthCubit>();

    Future.delayed(
      Duration(seconds: 2),
    ).then((_) => navigateBasedOnUserState());

    super.initState();
  }

  void navigateBasedOnUserState() {
    if (authCubit.state.userData?.uid != null &&
        authCubit.state.userData?.uid.isNotEmpty == true) {
      // appRouter.replaceAll([HomeRoute()]);
      if (authCubit.state.userData?.email == 'abhi@gmail.com') {
        appRouter.replaceAll([DashBoardRoute()]);
        return;
      } else {
        appRouter.replaceAll([HomeRoute(params: HomePageParams())]);
        return;
      }
    } else {
      appRouter.replaceAll([SignInForm()]);
      return;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      showSafeArea: false,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.splashGradient,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Center(
              child: SlideTransition(
                position: _animation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ImageLoader.assetSvg(
                      AppImages.splashImage,
                      height: 130.heightMultiplier,
                      width: 100.widthMultiplier,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
