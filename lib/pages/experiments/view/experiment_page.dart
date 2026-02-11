import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/common_app_bar.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/common_functions.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/core/utils/common_enums.dart';
import 'package:kailasha/pages/experiments/cubit/experiments_cubit.dart';
import 'package:kailasha/pages/experiments/view/experiment_details_page.dart';

class ExperimentPageParams {
  final String classLevel;
  final String? schoolId;
  ExperimentPageParams({required this.classLevel, this.schoolId});
}

@RoutePage()
class ExperimentPage extends StatefulWidget {
  final ExperimentPageParams parms;
  const ExperimentPage({super.key, required this.parms});

  @override
  State<ExperimentPage> createState() => _ExperimentPageState();
}

class _ExperimentPageState extends State<ExperimentPage> {
  late ExperimentsCubit experimentsCubit;
  @override
  void initState() {
    experimentsCubit = context.read<ExperimentsCubit>();
    experimentsCubit.fetchClassExperiments(
      classLevel: widget.parms.classLevel,
      schoolId: widget.parms.schoolId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      appBar: CommonAppBar(
        titleWidget: GradientText(
          text: 'Experiments',
          style: CustomTextStyle.customW600(fontSize: 22),
        ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 16.widthMultiplier),
        //     child: ClickableButton(
        //       onTap: () {
        //         appRouter.push(AddExperimentRoute());
        //       },
        //       child: Icon(
        //         Icons.add,
        //         size: 30.heightMultiplier,
        //         color: AppColors.textgradient[1],
        //       ),
        //     ),
        //   ),
        // ],
      ),
      child: CommonContainer(
        child: BlocBuilder<ExperimentsCubit, ExperimentsState>(
          builder: (context, state) {
            if (state.experimentApiStatus == ApiStatus.loading) {
              return CommonFunctions.progressIndicator();
            }
            if (state.experiments.isEmpty) {
              return Center(
                child: Text(
                  'No Experiments Yet!',
                  style: CustomTextStyle.customW500(fontSize: 16),
                ),
              );
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: state.experiments.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return 10.verticalSpace;
                    },
                    itemBuilder: (context, index) {
                      final experiment = state.experiments[index];
                      return ClickableButton(
                        onTap: () {
                          appRouter.push(
                            ExperimentDetailsRoute(
                              params: ExperimentDetailsPageParams(
                                experiment: experiment,
                                schoolId: widget.parms.schoolId,
                              ),
                            ),
                          );
                        },
                        child: GradientCommonContainer(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                experiment.isPerformed
                                    ? Icons.check
                                    : Icons.label,
                                color: AppColors.textgradient[0],
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    GradientText(
                                      text: experiment.experiment.title,
                                      style: CustomTextStyle.customW500(
                                        fontSize: 20,
                                      ),
                                    ),
                                    if (experiment.performedAt != null) ...[
                                      5.verticalSpace,
                                      Text(
                                        formatDate(
                                          experiment.performedAt ??
                                              DateTime.now(),
                                        ),
                                        style: CustomTextStyle.customW500(
                                          fontSize: 14,
                                          color: AppColors.primary
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
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
