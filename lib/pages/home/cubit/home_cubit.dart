import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/core/utils/common_enums.dart';
import 'package:kailasha/models/school_class/school_class_model.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';
import 'package:kailasha/repository/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required this.authCubit}) : super(HomeState.initial());
  AuthCubit authCubit;
  HomeRepo homeRepo = HomeRepo();

  Future<void> addClassToSchool({
    required String className, // e.g. "Class 8"
    String? section,
  }) async {
    final userId =  authCubit.state.userData?.uid;
    if (userId != null && userId.isNotEmpty == true) {
      await homeRepo.addClassToSchool(
        className: className,
        schoolId: userId,
        section: section,
      );
      await fetchSchoolClasses();
    }
  }

  Future<void> fetchSchoolClasses({String? schoolId}) async {
    final userId = schoolId ?? authCubit.state.userData?.uid;
    if (userId != null && userId.isNotEmpty == true) {
      emit(state.copyWith(homeApiStatus: ApiStatus.loading));
      final schoolClasses = await homeRepo.fetchSchoolClasses(schoolId: userId);
      emit(
        state.copyWith(
          classes: schoolClasses,
          homeApiStatus: ApiStatus.success,
        ),
      );
    }
  }

  void callInit() {
    emit(HomeState.initial());
  }
}
