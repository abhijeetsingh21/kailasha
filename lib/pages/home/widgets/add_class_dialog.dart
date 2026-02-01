import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/pages/home/cubit/home_cubit.dart';

class AddClassDialog extends StatefulWidget {
  final void Function(String className, String? section) onAdd;
  static Future<void> showAddDialog({
    required BuildContext context,
    required void Function(String, String?) onAdd,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AddClassDialog(onAdd: onAdd);
      },
    );
  }

  const AddClassDialog({super.key, required this.onAdd});

  @override
  State<AddClassDialog> createState() => _AddClassDialogState();
}

class _AddClassDialogState extends State<AddClassDialog> {
  final _formKey = GlobalKey<FormState>();

  final classController = TextEditingController();
  final sectionController = TextEditingController();
  late HomeCubit homeCubit;
  @override
  void initState() {
    homeCubit = context.read<HomeCubit>();
    super.initState();
  }

  @override
  void dispose() {
    classController.dispose();
    sectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white100,
      insetPadding: EdgeInsets.all(16.widthMultiplier),
      child: GradientCommonContainer(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Center(
                child: GradientText(
                  text: 'Add Class',
                  style: CustomTextStyle.customW600(fontSize: 18),
                ),
              ),

              16.verticalSpace,

              /// Class Name
              CustomTextField(
                controller: classController,
                hintText: 'Class Name (e.g. Class 8)',
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Required' : null,
              ),

              12.verticalSpace,

              /// Section (optional)
              CustomTextField(
                controller: sectionController,
                hintText: 'Section (optional)',
              ),

              20.verticalSpace,

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: ClickableButton(
                      onTap: () => appRouter.pop(context),
                      child: CommonContainer(
                        borderColor: AppColors.borderColor,
                        borderRadius: 8.radiusMultiplier,
                        alignment: Alignment.center,
                        child: Text(
                          'Cancel',
                          style: CustomTextStyle.size14W600(
                            color: AppColors.text2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  12.horizontalSpace,

                  Expanded(
                    child: ClickableButton(
                      onTap: () async {
                        await _onAdd();
                      },
                      child: GradientCommonContainer(
                        child: Center(
                          child: GradientText(
                            text: 'Add',
                            style: CustomTextStyle.customW600(fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAdd() async {
    if (!_formKey.currentState!.validate()) return;

    widget.onAdd(
      classController.text.trim(),
      sectionController.text.trim().isEmpty
          ? null
          : sectionController.text.trim(),
    );
    await homeCubit.addClassToSchool(
      className: classController.text,
      section: sectionController.text,
    );

    appRouter.pop(context);
  }
}
