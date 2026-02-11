import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/common_app_bar.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/common_functions.dart';
import 'package:kailasha/common/custom_button.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/core/utils/common_enums.dart';
import 'package:kailasha/models/custom_button_props_model/custom_button_props_model.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';
import 'package:kailasha/pages/experiments/view/experiment_page.dart';
import 'package:kailasha/pages/home/cubit/home_cubit.dart';
import 'package:kailasha/pages/home/widgets/add_class_dialog.dart';

class HomePageParams {
  final String? schoolId;
  final String? schoolName;
  HomePageParams({this.schoolId, this.schoolName});
}

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.params});
  final HomePageParams params;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeCubit homeCubit;
  late AuthCubit authCubit;
  @override
  void initState() {
    homeCubit = context.read<HomeCubit>();
    authCubit = context.read<AuthCubit>();
    homeCubit.callInit();
    homeCubit.fetchSchoolClasses(schoolId: widget.params.schoolId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      canPop: widget.params.schoolId == null ? false : true,
      appBar: CommonAppBar(
        showBackButton: widget.params.schoolId == null ? false : true,
        titleWidget: GradientText(
          text: widget.params.schoolName == null
              ? 'Prayog'
              : (widget.params.schoolName ?? ''),
          style: CustomTextStyle.customW600(fontSize: 22),
        ),

        actions: [
          if (widget.params.schoolId == null)
            Padding(
              padding: EdgeInsets.only(right: 16.widthMultiplier),
              child: ClickableButton(
                onTap: () {
                  AddClassDialog.showAddDialog(
                    context: context,
                    onAdd: (val1, val2) {},
                  );
                },
                child: Icon(
                  Icons.add,
                  size: 30.heightMultiplier,
                  color: AppColors.textgradient[1],
                ),
              ),
            ),
        ],
      ),
      child: CommonContainer(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.homeApiStatus == ApiStatus.loading) {
              return CommonFunctions.progressIndicator();
            }
            if (state.classes.isEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'No Classes Yet',
                        style: CustomTextStyle.customW500(fontSize: 16),
                      ),
                    ),
                  ),

                  if (widget.params.schoolId == null) ...[
                    10.verticalSpace,
                    CustomButton(
                      props: CustomButtonPropsModel(
                        onPressed: () async {
                          await authCubit.signOut();
                        },
                        text: 'Log out',
                        textStyle: CustomTextStyle.customW500(
                          fontSize: 16,
                          color: AppColors.white100,
                        ),
                      ),
                    ),
                  ],
                ],
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: state.classes.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return 10.verticalSpace;
                    },
                    itemBuilder: (context, index) {
                      final currentClass = state.classes[index];
                      return ClickableButton(
                        onTap: () {
                          appRouter.push(
                            ExperimentRoute(
                              parms: ExperimentPageParams(
                                classLevel: currentClass.name,
                                schoolId: widget.params.schoolId,
                              ),
                            ),
                          );
                        },
                        child: GradientCommonContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.label,
                                color: AppColors.textgradient[0],
                              ),
                              Expanded(
                                child: Center(
                                  child: Column(
                                    children: [
                                      GradientText(
                                        text: currentClass.name,
                                        style: CustomTextStyle.customW500(
                                          fontSize: 20,
                                        ),
                                      ),
                                      5.verticalSpace,
                                      Text(
                                        formatDate(
                                          currentClass.createdAt ??
                                              DateTime.now(),
                                        ),
                                        style: CustomTextStyle.customW500(
                                          fontSize: 16,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (widget.params.schoolId == null) ...[
                  10.verticalSpace,
                  CustomButton(
                    props: CustomButtonPropsModel(
                      onPressed: () async {
                        await authCubit.signOut();
                      },
                      text: 'Log out',
                      textStyle: CustomTextStyle.customW500(
                        fontSize: 16,
                        color: AppColors.white100,
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  String formatDate(DateTime createdAt) {
    return 'Created At - ${DateFormat('MMM dd yyyy').format(createdAt)}';
  }
}
