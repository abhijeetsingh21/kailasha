import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/common/image_loader.dart';
import 'package:kailasha/core/constants/app_images.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/pages/dashboard/cubit/dashboard_cubit.dart';

@RoutePage()
class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      // showSafeArea: false,
      child: AutoTabsScaffold(
        inheritNavigatorObservers: false,
        routes: const [HomeRoute(), HomeRoute(), HomeRoute(), HomeRoute()],

        bottomNavigationBuilder: (context, tabsRouter) {
          final cubit = context.read<DashboardCubit>();
          final activeIndex = tabsRouter.activeIndex;
          if (cubit.state.selectedIndex != activeIndex) {
            cubit.setIndex(activeIndex);
          }

          return BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, navState) {
              final currentIndex = navState.selectedIndex;

              return Container(
                height: 100.heightMultiplier,
                decoration: BoxDecoration(
                  color: AppColors.white100,
                  boxShadow: [
                    BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 8),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _NavItem(
                      index: 0,
                      label: 'Home',
                      isSelected: currentIndex == 0,
                      onTap: () {
                        if (tabsRouter.activeIndex != 0) {
                          tabsRouter.setActiveIndex(0);
                        }
                      },
                      asset: currentIndex == 0
                          ? AppIcons.homeGradientIcon
                          : AppIcons.homeIcon,
                    ),
                    _NavItem(
                      index: 1,
                      label: 'Earnings',
                      isSelected: currentIndex == 1,
                      onTap: () {
                        tabsRouter.setActiveIndex(1);
                      },
                      asset: currentIndex == 1
                          ? AppIcons.earningsGradientIcon
                          : AppIcons.earningIcon,
                    ),

                    _NavItem(
                      index: 2,
                      label: 'Notifications',
                      isSelected: currentIndex == 2,
                      onTap: () {
                        tabsRouter.setActiveIndex(2);
                      },
                      asset: currentIndex == 2
                          ? AppIcons.notificationGradientIcon
                          : AppIcons.notificationIcon,
                    ),
                    _NavItem(
                      index: 3,
                      label: 'Settings',
                      isSelected: currentIndex == 3,
                      onTap: () {
                        tabsRouter.setActiveIndex(3);
                      },
                      asset: currentIndex == 3
                          ? AppIcons.settingGradientIcon
                          : AppIcons.settingIcon,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final String asset;

  const _NavItem({
    required this.index,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = (isSelected
        ? AppColors.primary
        : AppColors.greyShade);

    final Color textColor = isSelected
        ? AppColors.primary
        : AppColors.greyShade;

    return Expanded(
      child: ClickableButton(
        onTap: onTap,
        borderRadius: 12,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ImageLoader.asset(
              asset,
              height: 28.heightMultiplier,
              fit: BoxFit.contain,
              // color: iconColor,
            ),

            6.verticalSpace,

            // SELECTED — gradient label
            if (isSelected)
              GradientText(
                text: label,
                gradient: LinearGradient(
                  colors: AppColors.textgradient,
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                style: CustomTextStyle.size13W600(),
              )
            // UNSELECTED — normal label
            else
              Text(label, style: CustomTextStyle.size13W600(color: textColor)),

            4.verticalSpace,
          ],
        ),
      ),
    );
  }
}
