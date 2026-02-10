import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/core/utils/common_enums.dart';
import 'package:kailasha/models/school_model/school_model.dart';
import 'package:kailasha/repository/schools_repo.dart';

part 'schools_state.dart';

class SchoolsCubit extends Cubit<SchoolsState> {
  SchoolsCubit() : super(SchoolsState.initial());

  Future<void> fetchAllSchoolsAsAdmin() async {
    emit(state.copyWith(schoolsApiStatus: ApiStatus.loading));

    final schools = await SchoolsRepo.fetchAllSchoolsAsAdmin();

    emit(state.copyWith(schools: schools, schoolsApiStatus: ApiStatus.success));
  }

  void callInit() {
    emit(SchoolsState.initial());
  }
}
