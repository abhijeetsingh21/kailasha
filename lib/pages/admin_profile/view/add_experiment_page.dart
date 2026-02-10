import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/app_dopdown.dart';
import 'package:kailasha/common/common_app_bar.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/custom_gradient_button.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/core/utils/custom_toast.dart';
import 'package:kailasha/models/science_experiment/science_experiment_model.dart';
import 'package:kailasha/pages/admin_profile/cubit/admin_profile_cubit.dart';
import 'package:kailasha/pages/experiments/cubit/experiments_cubit.dart';
import 'package:kailasha/pages/experiments/widgets/add_experiment_widgets/add_experiment_widgets.dart';

@RoutePage()
class AddExperimentPage extends StatefulWidget {
  const AddExperimentPage({super.key});

  @override
  State<AddExperimentPage> createState() => _AddExperimentPageState();
}

class _AddExperimentPageState extends State<AddExperimentPage> {
  late AdminProfileCubit adminProfileCubit;
  final _formKey = GlobalKey<FormState>();
  String? selectedClass;

  /// Basic fields
  final titleController = TextEditingController();
  final subjectController = TextEditingController();
  final classLevelController = TextEditingController();
  final aimController = TextEditingController();
  final theoryController = TextEditingController();
  final conclusionController = TextEditingController();

  /// Dynamic lists
  final List<TextEditingController> materialControllers = [];
  final List<TextEditingController> precautionControllers = [];
  final List<ObservationControllers> observationControllers = [];

  @override
  void initState() {
    adminProfileCubit = context.read<AdminProfileCubit>();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    subjectController.dispose();
    classLevelController.dispose();
    aimController.dispose();
    theoryController.dispose();
    conclusionController.dispose();

    for (final c in materialControllers) {
      c.dispose();
    }
    for (final c in precautionControllers) {
      c.dispose();
    }
    for (final o in observationControllers) {
      o.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      appBar: CommonAppBar(
        titleWidget: GradientText(
          text: 'Add Experiment',
          style: CustomTextStyle.customW600(fontSize: 20),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.heightMultiplier),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Section(
                title: 'Basic Details',
                children: [
                  Field('Title', titleController),
                  Field('Subject', subjectController),

                  // Class Level
                  AppDropdown(
                    list: [
                      'Class 6',
                      'Class 7',
                      'Class 8',
                      'Class 9',
                      'Class 10',
                      'Class 11',
                      'Class 12',
                    ],
                    hintText: 'Select Class',
                    callback: (val) {
                      setState(() {
                        selectedClass = val;
                      });
                    },
                  ),
                  12.verticalSpace,
                  Field('Aim', aimController, maxLines: 3),
                  Field('Theory', theoryController, maxLines: 5),
                ],
              ),

              DynamicTextListSection(
                title: 'Materials',
                controllers: materialControllers,
                hint: 'Enter material',
                onAdd: () => setState(() {
                  materialControllers.add(TextEditingController());
                }),
              ),

              DynamicObservationSection(
                observations: observationControllers,
                onAdd: () => setState(() {
                  observationControllers.add(ObservationControllers());
                }),
              ),

              Section(
                title: 'Conclusion',
                children: [
                  Field('Conclusion', conclusionController, maxLines: 3),
                ],
              ),

              DynamicTextListSection(
                title: 'Precautions',
                controllers: precautionControllers,
                hint: 'Enter precaution',
                onAdd: () => setState(() {
                  precautionControllers.add(TextEditingController());
                }),
              ),

              24.verticalSpace,

              CustomGradientButton(
                props: CustomGradientButtonProps(
                  onTap: () async {
                    await _onSubmit();
                  },
                  title: 'Create Experiment',
                  titleStyle: CustomTextStyle.customW600(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    if(selectedClass == null){
      AppUtils.customToast(message: 'Please select class!');
    return;
    } 
  
    final experiment = ScienceExperiment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      subject: subjectController.text,
      classLevel: selectedClass ?? '',
      aim: aimController.text,
      theory: theoryController.text,
      materials: materialControllers.map((c) => c.text).toList(),
      observations: observationControllers
          .map((o) => o.toObservation())
          .toList(),
      conclusion: conclusionController.text,
      precautions: precautionControllers.map((c) => c.text).toList(),
    );

    try {
      await adminProfileCubit.onAddExperiment(experiment: experiment,);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Experiment added successfully',
              style: CustomTextStyle.customW400(color: AppColors.white100),
            ),
          ),
        );
        appRouter.pop();
      }
      // use experiment later
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to add experiment: $e')));
      }
    }
  }
}
