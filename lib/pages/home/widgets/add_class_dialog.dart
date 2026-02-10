import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/app_dopdown.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/custom_gradient_button.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/core/utils/custom_toast.dart';
import 'package:kailasha/pages/home/cubit/home_cubit.dart';

class AddClassDialog extends StatefulWidget {
  static Future<void> showAddDialog({
    required BuildContext context,
    required void Function(String, String?) onAdd,
    String? schoolId,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return AddClassDialog(onAdd: onAdd, schooldId: schoolId);
      },
    );
  }

  final void Function(String className, String? section) onAdd;
  final String? schooldId;

  const AddClassDialog({super.key, required this.onAdd, this.schooldId});

  @override
  State<AddClassDialog> createState() => _AddClassDialogState();
}

class _AddClassDialogState extends State<AddClassDialog> {
  String? selectedClass;

  late HomeCubit homeCubit;
  @override
  void initState() {
    homeCubit = context.read<HomeCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white100,
      insetPadding: EdgeInsets.all(16.widthMultiplier),
      clipBehavior: Clip.none,
      child: GradientCommonContainer(
        borderRadius: 24.radiusMultiplier,
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
            AppDropdown(
              list: ['Class 6','Class 7','Class 8', 'Class 9','Class 10','Class 11','Class 12',],
              hintText: 'Select Class',
              callback: (val) {
                setState(() {
                  selectedClass = val;
                });
              },
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
                  child: CustomGradientButton(
                    props: CustomGradientButtonProps(
                      onTap: _onAdd,
                      title: 'Add',
                      titleStyle: CustomTextStyle.customW600(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onAdd() async {
    if (selectedClass == null) {
      AppUtils.customToast(message: 'Select a class');
      return;
    }
    await homeCubit.addClassToSchool(className: selectedClass ?? '');

    appRouter.pop();
  }
}
