import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/common/common_app_bar.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/custom_button.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/models/custom_button_props_model/custom_button_props_model.dart';
import 'package:kailasha/models/science_experiment/science_experiment_model.dart';
import 'package:kailasha/pages/experiments/cubit/experiments_cubit.dart';

class ExperimentDetailsPageParams {
  final MergedExperiment experiment;
  final String? schoolId;
  ExperimentDetailsPageParams({required this.experiment, this.schoolId});
}

@RoutePage()
class ExperimentDetailsPage extends StatefulWidget {
  final ExperimentDetailsPageParams params;

  const ExperimentDetailsPage({super.key, required this.params});

  @override
  State<ExperimentDetailsPage> createState() => _ExperimentDetailsPageState();
}

class _ExperimentDetailsPageState extends State<ExperimentDetailsPage> {
  bool isCompleted = false;
  @override
  void initState() {
    isCompleted = widget.params.experiment.isPerformed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final experimentCubit = context.read<ExperimentsCubit>();
    return CommonBackground(
      appBar: CommonAppBar(
        titleWidget: GradientText(
          text: widget.params.experiment.experiment.title,
          style: CustomTextStyle.customW600(fontSize: 20),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.heightMultiplier),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionCard(
                    title: 'Aim',
                    child: Text(
                      widget.params.experiment.experiment.aim,
                      style: CustomTextStyle.customW500(fontSize: 14),
                    ),
                  ),
                  12.verticalSpace,

                  _SectionCard(
                    title: 'Theory',
                    child: Text(
                      widget.params.experiment.experiment.theory,
                      style: CustomTextStyle.customW500(fontSize: 14),
                    ),
                  ),
                  12.verticalSpace,

                  _MaterialsSection(
                    materials: widget.params.experiment.experiment.materials,
                  ),
                  12.verticalSpace,

                  _ObservationsSection(
                    observations:
                        widget.params.experiment.experiment.observations,
                  ),
                  12.verticalSpace,

                  _SectionCard(
                    title: 'Conclusion',
                    child: Text(
                      widget.params.experiment.experiment.conclusion,
                      style: CustomTextStyle.customW500(fontSize: 14),
                    ),
                  ),
                  12.verticalSpace,

                  _PrecautionsSection(
                    precautions:
                        widget.params.experiment.experiment.precautions,
                  ),
                ],
              ),
            ),
          ),
          10.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.widthMultiplier),
            child: CustomButton(
              props: CustomButtonPropsModel(
                onPressed: () async {
                  if (!isCompleted) {
                    await experimentCubit
                        .markExperimentPerformed(
                          schoolId: widget.params.schoolId,
                          classLevel:
                              widget.params.experiment.experiment.classLevel,
                          experimentId: widget.params.experiment.experiment.id,
                        )
                        .then((isSuccess) {
                          if (isSuccess) {
                            setState(() {
                              isCompleted = true;
                            });
                          }
                        });
                  }
                },
                text: isCompleted ? 'Completed' : 'Mark As Done',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return GradientCommonContainer(
      width: double.infinity,
      borderWidth: 1.5.widthMultiplier,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText(
            text: title,
            style: CustomTextStyle.customW600(fontSize: 16),
          ),
          8.verticalSpace,
          child,
        ],
      ),
    );
  }
}

class _MaterialsSection extends StatelessWidget {
  final List<String> materials;

  const _MaterialsSection({required this.materials});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Materials Required',
      child: Wrap(
        spacing: 8.widthMultiplier,
        runSpacing: 8.heightMultiplier,
        children: materials.map((m) {
          return CommonContainer(
            padding: EdgeInsets.symmetric(
              horizontal: 12.widthMultiplier,
              vertical: 6.heightMultiplier,
            ),
            borderColor: AppColors.textgradient.first,
            child: Text(m, style: CustomTextStyle.size14W500()),
          );
        }).toList(),
      ),
    );
  }
}

class _ObservationsSection extends StatelessWidget {
  final List<Observation> observations;

  const _ObservationsSection({required this.observations});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Observations',
      child: Column(
        children: observations.map((o) {
          return Padding(
            padding: EdgeInsets.only(bottom: 8.heightMultiplier),
            child: GradientCommonContainer(
              padding: EdgeInsets.all(10.heightMultiplier),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(o.observation, style: CustomTextStyle.size13W600()),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _PrecautionsSection extends StatelessWidget {
  final List<String> precautions;

  const _PrecautionsSection({required this.precautions});

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      title: 'Precautions',
      child: Column(
        children: precautions.map((p) {
          return Padding(
            padding: EdgeInsets.only(bottom: 6.heightMultiplier),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.circle,
                  size: 6.radiusMultiplier,
                  color: AppColors.textgradient.first,
                ),
                8.horizontalSpace,
                Expanded(child: Text(p, style: CustomTextStyle.size14W500())),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
