import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/app/app.dart';
import 'package:kailasha/common/clickable_button.dart';
import 'package:kailasha/common/common_app_bar.dart';
import 'package:kailasha/common/common_background.dart';
import 'package:kailasha/common/common_container.dart';
import 'package:kailasha/common/common_functions.dart';
import 'package:kailasha/common/custom_button.dart';
import 'package:kailasha/common/custom_textfield.dart';
import 'package:kailasha/common/gradient_text.dart';
import 'package:kailasha/core/navigator/app_router.gr.dart';
import 'package:kailasha/core/theme/app_colors.dart';
import 'package:kailasha/core/theme/app_size.dart';
import 'package:kailasha/core/theme/app_text_style.dart';
import 'package:kailasha/core/utils/common_enums.dart';
import 'package:kailasha/models/custom_button_props_model/custom_button_props_model.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';
import 'package:kailasha/pages/home/view/home_page.dart';
import 'package:kailasha/pages/home/widgets/add_class_dialog.dart';
import 'package:kailasha/pages/schools/cubit/schools_cubit.dart';

@RoutePage()
class SchoolsPage extends StatefulWidget {
  const SchoolsPage({super.key});

  @override
  State<SchoolsPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolsPage> {
  late SchoolsCubit schoolsCubit;
  late AuthCubit authCubit;
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    schoolsCubit = context.read<SchoolsCubit>();
    authCubit = context.read<AuthCubit>();
    schoolsCubit.fetchAllSchoolsAsAdmin();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      canPop: false,
      appBar: CommonAppBar(
        titleWidget: GradientText(
          text: 'Schools',
          style: CustomTextStyle.customW600(fontSize: 22),
        ),

        showBackButton: false,
      ),
      child: Column(
        children: [
          CommonContainer(
            child: CustomTextField(
              controller: _searchController,
              hintText: 'Search Schools',
              maxlines: 1,
              useLabelText: false,
              borderColor: AppColors.blue,
              onChanged: (value) {
                schoolsCubit.onSearchChanged(searchQuery: value);
              },
            ),
          ),
          Expanded(
            child: CommonContainer(
              child: BlocBuilder<SchoolsCubit, SchoolsState>(
                builder: (context, state) {
                  if (state.schoolsApiStatus == ApiStatus.loading) {
                    return CommonFunctions.progressIndicator();
                  }
                  if (state.schools.isEmpty) {
                    return Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              'No Schools!',
                              style: CustomTextStyle.customW500(fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: state.schools.length,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return 10.verticalSpace;
                          },
                          itemBuilder: (context, index) {
                            final currentSchool = state.schools[index];
                            return ClickableButton(
                              onTap: () {
                                appRouter.push(
                                  HomeRoute(
                                    params: HomePageParams(
                                      schoolId: currentSchool.id,
                                      schoolName: currentSchool.name,
                                    ),
                                  ),
                                );
                              },
                              child: GradientCommonContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                              text: currentSchool.name,
                                              style: CustomTextStyle.customW500(
                                                fontSize: 20,
                                              ),
                                            ),
                                            5.verticalSpace,
                                            GradientText(
                                              text: currentSchool.city,
                                              style: CustomTextStyle.customW500(
                                                fontSize: 20,
                                              ),
                                            ),
                                            5.verticalSpace,
                                            GradientText(
                                              text: currentSchool.email,
                                              style: CustomTextStyle.customW500(
                                                fontSize: 20,
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
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
